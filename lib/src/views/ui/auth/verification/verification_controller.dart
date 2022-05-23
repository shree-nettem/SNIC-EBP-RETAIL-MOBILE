import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class VerificationXController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController;

  bool isPhoneNumber = true;
  bool isOTP = false;
  bool isEmail = true;
  bool isConfirmEmail = false;
  bool isEmailVerified = false;
  String phoneNumber;

  bool isChecked = false;
  bool isMyInformationChecked = false;

  bool disabled = true;

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  void setPhoneNumber(value) {
    phoneNumber = value;
  }

  void onTermsChecked() {
    if (isChecked) {
      isChecked = false;
    } else {
      isChecked = true;
    }
    debugPrint("IS CHECKED $isChecked");
    isEnabled();
  }

  void agreeMyInformation() {
    if (isMyInformationChecked) {
      isMyInformationChecked = false;
    } else {
      isMyInformationChecked = true;
    }
    debugPrint("IS INFORMATION $isMyInformationChecked");
    isEnabled();
  }

  void isEnabled() {
    if (isMyInformationChecked &&
        isChecked &&
        AppFormFieldValidator.validateMobile(phoneController.text) == null) {
      disabled = false;
    } else {
      disabled = true;
    }
    update();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
