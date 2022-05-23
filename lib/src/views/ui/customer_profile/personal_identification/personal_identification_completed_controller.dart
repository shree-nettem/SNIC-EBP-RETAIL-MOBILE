import 'dart:convert';
import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/auth/verification/verification_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PersonalIdentificationCompletedXController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController animationController;
  bool isIdentityVerifyCPR = true;
  bool isIdentityFacial = false;
  bool isAnalyzed = false;
  File image;
  final picker = ImagePicker();
  int count = 0;
  int targetCount = 5;
  int userId, stepId;
  bool showAnimation = true;
  String token;

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments['id'];
      stepId = Get.arguments['step_id'];
      debugPrint("USER ID $userId");
      getToken();
    }
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    var accessToken = await _sharedPreferencesHelper.getAccessToken;
    token = accessToken;
  }

  analyse(bool isAnalyzing) async {
    animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          showAnimation = isAnalyzing;
          update();
        }
      });
  }

  void getVerificationResponse() async {
    isAnalyzed = true;
    update();
    if (Utils.isInternetConnected() != null) {
      Result result = await DioClient()
          .get('Customer/OnboardingResult', token, isLoading: false);
      if (result is SuccessState) {
        isAnalyzed = false;

        var jsonData = VerificationResponseModel.fromJson(result.value);
        if (jsonData is VerificationResponseModel) {
          /* HIT SET IDENTITY VERIFICATION API */

          final body = json.decode(jsonData.benefitResponse);

          final messageStatus = body["messageStatus"];
          var amlResponse;
          if (body != null && messageStatus == "OK") {
            var jumioAMLResponse;
            if (jsonData.jumioAMLResponse != null) {
              jumioAMLResponse = json.decode(jsonData.jumioAMLResponse);
              debugPrint(
                  "MESSAGE_STATUS ${jumioAMLResponse["document"]["status"]}");
              amlResponse = jumioAMLResponse["document"]["status"];
            }
            if (amlResponse == "APPROVED_VERIFIED") {
              setExistedProfileAndUser(body);
            } else {
              isAnalyzed = false;
              update();
              errorMessage("Kindly contact the Administrator");
            }
          } else {
            isAnalyzed = false;
            update();
            errorMessage("No records found from Benefits");
          }
        }
      } else if (result is ErrorState) {
        isAnalyzed = false;
        update();
        errorMessage(result.msg.toString());
      }
    } else {
      isAnalyzed = false;
      update();
      errorMessage("Please connect to the network");
    }
  }

  /* POST THE DATA TO SERVER TO SET THE PROFILE (EXISTING USER) */
  void setExistedProfileAndUser(benefitResponseBody) async {
    String firstName = benefitResponseBody["IGAFeilds"]["firstNameEn"] ?? " ";
    String middleName =
        benefitResponseBody["IGAFeilds"]["middleName1En"] ?? " ";
    String lastName = benefitResponseBody["IGAFeilds"]["lastNameEn"] ?? " ";
    String gender = benefitResponseBody["IGAFeilds"]["gender"] ?? " ";
    String dateOfBirth = benefitResponseBody["IGAFeilds"]["dateOfBirth"] ?? " ";
    String telephoneNumber =
        benefitResponseBody["IGAFeilds"]["telephoneNumber"] ?? " ";
    String email = benefitResponseBody["IGAFeilds"]["email"] ?? " ";
    String addressType = benefitResponseBody["IGAFeilds"]["addressType"] ?? " ";
    String placeOfBirth =
        benefitResponseBody["IGAFeilds"]["placeOfBirth"] ?? " ";
    String nationality = benefitResponseBody["IGAFeilds"]["nationality"] ?? " ";
    String passportNumber =
        benefitResponseBody["IGAFeilds"]["passportNumber"] ?? " ";
    String idNumber = benefitResponseBody["IGAFeilds"]["idNumber"] ?? " ";
    int flatNumber = benefitResponseBody["IGAFeilds"]["flatNumber"] ?? " ";
    int buildingNumber =
        benefitResponseBody["IGAFeilds"]["buildingNumber"] ?? " ";
    String buildingAlpha = benefitResponseBody["IGAFeilds"]["buildingAlpha"];
    int roadNumber = benefitResponseBody["IGAFeilds"]["roadNumber"] ?? " ";
    int blockNumber = benefitResponseBody["IGAFeilds"]["blockNumber"] ?? " ";
    String occupation = benefitResponseBody["IGAFeilds"]["occupation"];
    String employeeName = benefitResponseBody["IGAFeilds"]["nameOfEmployer"];
    // String employeeAddress = benefitResponseBody["IGAFeilds"]["occupation"];

    var setExistProfileRequest = {
      "SavingWithGhady": "",
      "GeneralInsurance": "",
      "ViewingMedicalBenefits": "",
      "MailingAddressTown": "",
      "MailingAddressBlock": "",
      "MailingAddressRoad": "",
      "MailingAddressHouse": "",
      "MailingAddressFlat": "",
      "MailingAddressAlpha": "",
      "HomeAddressTown": "",
      "HomeAddressBlock": "",
      "HomeAddressRoad": "",
      "HomeAddressHouse": "",
      "HomeAddressFlat": "",
      "HomeAddressAlpha": "",
      "SourceOfIncome": "",
      "MonthlyIncome": ""
    };

    Result result = await DioClient().post(
        'Onboarding/SetExistedProfileAndUser?id=$userId',
        setExistProfileRequest,
        isPostData: true);
    if (result is SuccessState) {
      Get.offAllNamed(AppRoutes.DASHBOARD);
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    animationController.dispose();
  }
}
