import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import '../../../utilities/ui_constants.dart';
import '../../../utilities/utils.dart';
import 'package:ebpv2/src/views/ui/register/register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterXController extends GetxController {
  TextEditingController emailController, passwordController, idNumberController;
  final emailFocusNode = FocusNode();
  final idNumberFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  var currentSelection = 0;
  bool isValid = false;
  bool agreed = false;
  bool isVisible = false;
  final RegisterRepository _repository = RegisterRepository();
  var cprErrorMessage = "ID number must be all numeric and 9-15 digits long.";
  var passportErrorMessage = "ID number must be 4-15 characters long.";
  var segmentErrorMessage;

  Map<int, Widget> identityType = {
    0: Text(
      "CPR",
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    1: Text(
      'Passport No',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
  };

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    idNumberController = TextEditingController();
    currentSelection = 0;
    segmentErrorMessage = cprErrorMessage;
    resetValidate();
    super.onInit();
  }

  setSegmentState(int index) {
    currentSelection = index;
    segmentErrorMessage =
        (currentSelection == 0) ? cprErrorMessage : passportErrorMessage;
    update();
  }

  void termsAgreed(bool isChecked) {
    agreed = isChecked ? true : false;
    isVisible = !agreed ? true : false;
    update();
  }

  Map<String, bool> validate = {};

  void resetValidate() {
    validate = {
      "email": false,
      "id_number": false,
      "password": false,
    };
    update();
  }

  //VALIDATION OF THE FORM
  updateRegisterEmailValidation() {
    if (!Utils.validateEmail(emailController.text)) {
      updateValidateWithKeyValue('email', true);
    } else {
      updateValidateWithKeyValue('email', false);
    }
    setValidator();
  }

  updateRegisterIDValidation() {
    if (currentSelection == 0) {
      if (idNumberController.text.length >= 9 &&
          idNumberController.text.length < 15) {
        updateValidateWithKeyValue('id_number', false);
      } else {
        updateValidateWithKeyValue('id_number', true);
      }
    } else {
      if (idNumberController.text.length >= 4 &&
          idNumberController.text.length < 15) {
        updateValidateWithKeyValue('id_number', false);
      } else {
        updateValidateWithKeyValue('id_number', true);
      }
    }

    setValidator();
  }

  updateRegisterPasswordValidation() {
    if (!Utils.validatePassword(passwordController.text)) {
      updateValidateWithKeyValue('password', true);
    } else {
      updateValidateWithKeyValue('password', false);
    }
    setValidator();
  }

  void setValidator() {
    isValid = true;
    validate.forEach((key, value) {
      if (value == true) {
        isValid = false;
      }
    });
  }

  //SUBMIT BUTTON FORM VALIDATION
  validateSubmit() {
    if (!Utils.validateEmail(emailController.text)) {
      updateValidateWithKeyValue("email", true);
    } else {
      updateValidateWithKeyValue("email", false);
    }
    if (!Utils.validatePassword(passwordController.text)) {
      updateValidateWithKeyValue("password", true);
    } else {
      updateValidateWithKeyValue("password", false);
    }
    if (currentSelection == 0) {
      if (idNumberController.text.length >= 9 &&
          idNumberController.text.length < 15) {
        updateValidateWithKeyValue('id_number', false);
      } else {
        updateValidateWithKeyValue('id_number', true);
      }
    } else {
      if (idNumberController.text.length >= 4 &&
          idNumberController.text.length < 15) {
        updateValidateWithKeyValue('id_number', false);
      } else {
        updateValidateWithKeyValue('id_number', true);
      }
    }
    setValidator();
  }

  void updateValidateWithKeyValue(String key, bool value) {
    validate[key] = value;
    update();
  }

  //BUTTON CLICK
  void submit() {
    print("VALID API: $isValid");
    if (isValid) {
      if (agreed) {
        isVisible = false;
        _unFocus();
        if (Utils.isInternetConnected() != null) {
          registerUser();
        } else {
          errorMessage("Please connect to the network");
        }
      } else {
        isVisible = true;
        update();
      }
    } else {
      //IF USER DIRECTLY PRESSES BUTTON WITHOUT INSERTING DATA
      validateSubmit();
    }
  }

  registerUser() async {
    ResultV1 result = await _repository.register(
        emailController.text, passwordController.text, idNumberController.text);

    if (result is SuccessState) {
      if (result.value is String) {
        resetValidate();
        successMessage("Activation code sent!");
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  openAlertDialog() {
    Utils.showAlertDialogHelp(Get.context, "Kindly send your request to", "Ok");
    update();
  }

  @override
  void onClose() {
    _unFocus();
    emailController.dispose();
    idNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _unFocus() {
    this.emailFocusNode.unfocus();
    this.idNumberFocusNode.unfocus();
    this.passwordFocusNode.unfocus();
  }
}
