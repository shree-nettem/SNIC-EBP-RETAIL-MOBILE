import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../customer_profile_model.dart';

class ChangeMobileXController extends GetxController {
  GlobalKey<FormState> formKey;
  TextEditingController mobileController;
  TextEditingController otpController;
  String mobile, otp;
  CustomerProfileModel details;
  String token = '';
  String initialCountry = 'BH';
  PhoneNumber number;
  String selectedCountryCode = "+973";

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    mobileController = TextEditingController();
    otpController = TextEditingController();
    number = PhoneNumber(isoCode: 'BH');
    getToken();
  }

  void updatedCountryCode(String val) {
    selectedCountryCode = val;
  }

  void setMobile(value) {
    // mobile = value;
  }

  void setOTP(value) {
    otp = value;
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    var accessToken = await _sharedPreferencesHelper.getAccessToken;
    token = accessToken;
  }

  void changeMobile() {
    details = Get.find<CustomerProfileController>().customerDetails;

    var basicInfoRequestMap = {
      "FirstName": details.details.name,
      "MiddleName": details.details.middleName,
      "LastName": details.details.lastName,
      "PersonalEmail": details.details.personalEmail,
      "Gender": details.details.gender,
      "MaritalStatus": details.details.maritalStatus,
      "DateOfBirth": details.details.dateOfBirth,
      "MobileNumberOTP": otpController.text,
      "MobileNumber": parseNumber(),
      "Position": details.details.position,
      "CountryCode": selectedCountryCode
    };

    postBasicInfo(basicInfoRequestMap);
  }

  /* POST THE DATA TO SERVER */
  postBasicInfo(basicInfoRequestMap) async {
    Result result = await DioClient().post(
      'Customer/SaveProfileBasicInformation',
      basicInfoRequestMap,
      token: token,
      isPostData: true,
    );
    if (result is SuccessState) {
      Get.offAllNamed(AppRoutes.DASHBOARD);
    } else if (result is ErrorState) {
      ErrorResponse error = ErrorResponse.fromJson(result.msg);
      // Get.back();
      errorMessage(error.message);
    }
  }

  parseNumber() {
    return this
        .mobileController
        .text
        .replaceAll("+${this.selectedCountryCode}", '');
  }

  @override
  void onClose() {
    super.onClose();
    mobileController.dispose();
    otpController.dispose();
  }
}
