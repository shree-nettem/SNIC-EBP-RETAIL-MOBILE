import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../verification_model.dart';

class VerifyOtpXController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController codeController;
  TextEditingController otpController;
  TextEditingController emailController;
  String phoneNumber;
  String emailAddress;
  int userId, stepId;
  bool isPhoneNumber = true;
  bool isOTP = false;
  bool isEmail = true;
  bool isConfirmEmail = false;
  bool isEmailVerified = false;
  bool isAnalyzed = false;
  bool isFromProfile = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      phoneNumber = Get.arguments['phone_number'];
      userId = Get.arguments['id'];
      stepId = Get.arguments['step_id'];
      debugPrint("USER ID $userId");
      /* IF STEP ID IS 2, THEN THE VERIFICATION HAS BEEN COMPLETED AND REDIRECT USER TO EMAIL VERIFIED SCREEN
      WITH REFERRAL CODE OPTION */
      if (stepId == 2) {
        isEmail = false;
        isConfirmEmail = false;
        isEmailVerified = true;
        update();
      }
    }
    codeController = TextEditingController();
    otpController = TextEditingController();
    emailController = TextEditingController();
    super.onInit();
  }

  //CHECK WHETHER THE OTP IS CONFIRMED OR NOT
  void checkPhoneOTPConfirmed() {
    isEmail = true;
    isPhoneNumber = false;
    isOTP = false;
    isConfirmEmail = false;
    isEmailVerified = false;
    update();
  }

  //VERIFY THE ACCOUNT USING OTP PHONE
  void enablePhone(type) {
    if (Utils.isInternetConnected() != null) {
      verifyOTP(type);
    } else {
      errorMessage("Please connect to the network");
    }
  }

  //VERIFY THE ACCOUNT USING OTP EMAIL
  void enableEmail(type) {
    if (Utils.isInternetConnected() != null) {
      verifyOTP(type);
    } else {
      errorMessage("Please connect to the network");
    }
  }

  Future<void> verifyOTP(type) async {
    String code = otpController.text;
    String apiEndPointWithParams =
        'Onboarding/VerifyOTP?id=$userId&type=$type&otp=$code';

    debugPrint("VERIFY_OTP $apiEndPointWithParams");
    Result result = await DioClient().get(apiEndPointWithParams, "");
    if (result is SuccessState) {
      var jsonData = VerificationModel.fromJson(result.value);
      if (jsonData is VerificationModel) {
        if (jsonData.currentStepId == 1) {
          successMessage("Phone number successfully verified");
          Future.delayed(const Duration(seconds: 1), () {
            Get.toNamed(AppRoutes.CONFIRM_EMAIL, arguments: {
              'id': jsonData.iD,
              "step_id": 1,
            });
          });
        } else if (jsonData.currentStepId == 2) {
          successMessage("Email successfully verified");
          isEmail = false;
          isConfirmEmail = false;
          isEmailVerified = true;
          update();
        }
      } else {
        errorMessage("Could not verify phone number");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  //WHEN USER PRESSES RESENT OTP TEXT
  void resendOTP(String type) async {
    String apiEndPointWithParams = 'Onboarding/ResendOTP?id=$userId&type=$type';

    debugPrint("RESEND OTP $apiEndPointWithParams");
    Result result =
        await DioClient().post(apiEndPointWithParams, "", isPostData: false);
    if (result is SuccessState) {
      var jsonData = VerificationModel.fromJson(result.value);
      if (jsonData is VerificationModel) {
        int stepId = jsonData.currentStepId;
        successMessage("OTP resent successfully");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.clear();

    super.onClose();
  }
}
