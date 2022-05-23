import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../customer_profile_model.dart';

class ChangeEmailXController extends GetxController {
  GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController otpController;
  String email, otp;
  CustomerProfileModel details;
  String token = '';

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    otpController = TextEditingController();
    getToken();
  }

  void setEmail(value) {
    email = value;
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

  void changeEmail() {
    details = Get.find<CustomerProfileController>().customerDetails;

    var basicInfoRequestMap = {
      "FirstName": details.details.name,
      "MiddleName": details.details.middleName,
      "LastName": details.details.lastName,
      "PersonalEmailOTP": otpController.text,
      "PersonalEmail": emailController.text,
      "Gender": details.details.gender,
      "MaritalStatus": details.details.maritalStatus,
      "DateOfBirth": details.details.dateOfBirth,
      "MobileNumber": details.details.mobileNumber,
      "Position": details.details.position,
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
      errorMessage(result.msg.error.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    otpController.dispose();
  }
}
