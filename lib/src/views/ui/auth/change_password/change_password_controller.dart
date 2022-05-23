import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordXController extends GetxController {
  GlobalKey<FormState> formKey;
  TextEditingController currentPasswordController,
      newPasswordController,
      confirmPasswordController;
  String token;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  void changePassword() async {
    await getToken();
    Map<String, dynamic> body = {
      "OldPassword": currentPasswordController.text,
      "NewPassword": newPasswordController.text,
      "ConfirmPassword": confirmPasswordController.text,
    };

    Result result =
        await DioClient().post('ChangePassword', body, token: token);
    if (result is SuccessState) {
      Get.back();
      errorMessage("Password successfully changed!", title: "success".tr);
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  @override
  void onClose() {
    super.onClose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}
