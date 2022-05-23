import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/models/loyalty_points_details_model.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/models/loyalty_points_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoyaltyPointsHistoryController extends GetxController {
  String token;
  List<LoyaltyPointsHistoryResult> loyaltyTransactionHistoryList = [];
  LoyaltyPointsDetailsResult loyaltyPointsDetails;
  GlobalKey<FormState> formKey;
  TextEditingController mobileNumberController, pointsController;
  String initialCountry = 'BH';
  PhoneNumber number;
  String selectedCountryCode = "+973";
  String customerName;
  RxInt remainingPoints = 0.obs;
  num points = 0.0;
  int outstandingPoints = 0;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    mobileNumberController = TextEditingController();
    pointsController = TextEditingController();
    number = PhoneNumber(isoCode: 'BH');
    fetchData();
  }

  fetchData() async {
    await getToken();

    var response = await Future.wait([
      DioClient()
          .get("Loyalty/GetLoyaltyPointsHistory", token, keepLoading: true),
    ]);
    var responses = await Future.wait([
      DioClient().get(
        "Loyalty/GetCustomerLoyaltyPointsDetails",
        token,
        isLoading: false,
      ),
    ]);

    fetchLoyaltyPointsHistory(response[0]);
    fetchLoyaltyPointsDetails(responses[0]);
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    var accessToken = await _sharedPreferencesHelper.getAccessToken;
    token = accessToken;
  }

  // FETCH LOYALTY POINTS HISTORY
  fetchLoyaltyPointsHistory(result) async {
    if (result is SuccessState) {
      var jsonData = LoyaltyPointsHistoryModel.fromJson(result.value);
      if (jsonData != null) {
        loyaltyTransactionHistoryList = jsonData.loyaltyPointsHistoryResult;
        debugPrint("SUCCESS ${loyaltyTransactionHistoryList.length}");
      }
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  // FETCH LOYALTY POINTS DETIALS
  fetchLoyaltyPointsDetails(result) async {
    if (result is SuccessState) {
      var jsonData = LoyaltyPointsDetailsModel.fromJson(result.value);
      if (jsonData != null) {
        loyaltyPointsDetails = jsonData.loyaltyPointsDetailsResult;
        outstandingPoints = loyaltyPointsDetails.outstandingPoints.toInt();
        remainingPoints.value = outstandingPoints;
      }
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  void updatedCountryCode(String val) {
    selectedCountryCode = val;
  }

  void calculateRemainingPoints(String value) {
    if (value.isNotEmpty) {
      int points =
          (loyaltyPointsDetails.outstandingPoints.toInt() - int.parse(value));

      remainingPoints.value = points;
      debugPrint("REMAINING $remainingPoints");
    } else {
      remainingPoints.value = loyaltyPointsDetails.outstandingPoints;
    }
  }

  // CALL THIS API TO GET THE CUSTOMER NAME
  getCustomerName() {
    if (Utils.isInternetConnected() != null) {
      return getUserName();
    } else {
      errorMessage("Please connect to the network");
    }
  }

  getUserName() async {
    String mobileNumber =
        AppHelper.parseNumber(mobileNumberController.text, initialCountry);

    Result result = await DioClient().get(
      "Customer/GetCustomerNameFromMobileNumber?mobileNumber=$mobileNumber&countryCode=$selectedCountryCode",
      token,
    );
    if (result is SuccessState) {
      customerName = result.value["result"];
      return customerName;
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  //TRANSFER THE POINTS
  transferPoints() async {
    String mobileNumber =
        AppHelper.parseNumber(mobileNumberController.text, initialCountry);
    Result result = await DioClient().post(
      'Loyalty/LoyaltyPointsTransfer?mobileNumber=$mobileNumber&points=${pointsController.text}&countryCode=$selectedCountryCode',
      "",
      isPostData: false,
      token: token,
    );
    if (result is SuccessState) {
      successMessage("Points has been transferred successfully");
      Get.offAndToNamed(AppRoutes.LOYALTY_HOME);
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    mobileNumberController.dispose();
    pointsController.dispose();
  }
}
