import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController cprController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey;
  String otp;
  String phoneNumber;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    cprController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    if (Get.arguments != null) {
      debugPrint("OTP RESET " + Get.arguments[0]['otp']);
      var myInt = Get.arguments[0]['otp'];
      phoneNumber = Get.arguments[1]['phone'];
      otp = myInt;
    }
  }

  void resetPassword() async {
    Map<String, dynamic> body = {
      "PhoneNumber": phoneNumber,
      "RequestType": "sms",
      "Password": passwordController.text,
      "ConfirmPassword": passwordController.text,
      "Email": cprController.text.trim(),
      "code": otp
    };

    Result result = await DioClient().post('ResetPassword', body);
    if (result is SuccessState) {
      errorMessageWithAction("passwordChanged".tr, title: "success".tr,
          okBtnClicked: () {
        Get.back();
        Get.offNamed(AppRoutes.LOGIN);
      });
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  @override
  void onClose() {
    cprController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
