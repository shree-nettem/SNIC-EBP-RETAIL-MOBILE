import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/auth/login/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyPasswordController extends GetxController {
  bool isEmailChange = false;
  GlobalKey<FormState> formKey;
  TextEditingController passwordController;
  String password = "";
  SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
  String email, token, dialCode;
  String type;
  RxString requester = ''.obs;
  RxBool otpEntered = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isEmailChange = Get.arguments["change_email"];
      debugPrint("CHANGE_EMAIL $isEmailChange");
      type = isEmailChange ? "CustomerPersonalEmail" : "CustomerMobileNumber";
    }

    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    getEmail();
  }

  void setPassword(value) {
    password = value;
  }

  void verifyPassword() async {
    authenticateUser();
  }

  updateRequester(String value) {
  
      // if (dialCode == null) {
      //   return errorMessage("Please select a vaild dialCode");
      // }
      requester.value = value;
      print("requester.value ${requester.value}");

  }

  // updateDialCode(String v) {
  //   print("dial code update");
  //   dialCode = v;
  // }

  Future<String> getEmail() async {
    email = await _sharedPreferencesHelper.getEmail;
    token = await _sharedPreferencesHelper.getAccessToken;
    return email;
  }

  /* VERIFY THE USER BEFORE SENDING OTP */
  authenticateUser() async {
    var loginMap = {
      "UserName": email,
      "Password": passwordController.text,
      "AppID": "EBP_RETAIL",
    };

    debugPrint("LOGIN $loginMap");

    Result result = await DioClient().post('Authenticate', loginMap);
    if (result is SuccessState) {
      var jsonData = LoginModel.fromJson(result.value);
      if (jsonData is LoginModel) {
        int currentStepId = jsonData.onboarding.currentStepId;
        /* STEP ID 5 -> CUSTOMER VERIFIED COMPLETELY AND LOGIN */
        if (currentStepId == 5 || currentStepId == 4 || currentStepId == 3) {
          isEmailChange
              ? Get.toNamed(AppRoutes.CHANGE_EMAIL)
              : Get.toNamed(AppRoutes.CHANGE_MOBILE);
        } else {
          errorMessage("Your account is not activated!");
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  /* REQUEST FOR OTP BASED ON THE TYPE */
  requestOTP() async {
    print("calling req");
    if (requester.value.isEmpty || requester.value == '') {
      print("requester is empty");
      errorMessage("Add a vaild phone number");
      return;
    }
    Result result = await DioClient().get(
        'Account/RequestExistedOTP?type=$type&requester=${requester.value}',
        token);
    if (result is SuccessState) {
      print("$type success");
      successMessage("OTP Sent!");
      otpEntered.value = true;
      // isEmailChange
      //     ? Get.toNamed(AppRoutes.CHANGE_EMAIL)
      //     : Get.toNamed(AppRoutes.CHANGE_MOBILE);
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }
}
