import 'dart:io';

import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../utilities/ui_constants.dart';
import '../../../utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'employee_profile_wizard_two_screen.dart';

class EmployeeProfileXController extends GetxController {
  File image;
  final picker = ImagePicker();
  String date;
  TextEditingController dobController,
      firstNameController,
      middleNameController,
      lastNameController,
      contactController,
      emailController;
  var emailFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  bool isValid = false;
  var email;
  List<String> countries;
  String roleValue;
  var token;
  Map<int, Widget> genderType = {
    0: Text(
      "MALE",
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    1: Text(
      'FEMALE',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
  };
  var genderSelection;
  var isMale = "m";

  @override
  void onInit() {
    super.onInit();
    dobController = TextEditingController();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    contactController = TextEditingController();
    emailController = TextEditingController();
    resetValidate();
    getEmail();
  }

  getEmail() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    email = await _sharedPreferencesHelper.getName;
    emailController.text = email;
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //SHOW DATE PICKER
  selectDate() async {
    await showDatePicker(
      context: Get.context,
      initialDate: selectedDate,
      firstDate: DateTime(1936, 1),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != selectedDate) {
        date = DateFormat("yyyy-MM-ddTHH:mm:ss").format(pickedDate);
        dobController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      }
    });
    update();
  }

  //SET GENDER SEGMENT STATE
  setGenderSegmentState(var index) {
    genderSelection = index;
    isMale = (genderSelection == 0) ? "m" : "f";
    print("GENDER $isMale");
    update();
  }

  Map<String, bool> validate = {};

  void resetValidate() {
    validate = {
      "first_name": false,
      "last_name": false,
      "contact": false,
      "dob": false,
      "email": false,
    };
    update();
  }

  // VALIDATION OF THE FORM
  updateProfileFNameValidation() {
    if (firstNameController.text.isNotEmpty) {
      updateValidateWithKeyValue('first_name', false);
    } else {
      updateValidateWithKeyValue('first_name', true);
    }

    setValidator();
  }

  updateProfileLNameValidation() {
    if (firstNameController.text.isNotEmpty) {
      updateValidateWithKeyValue('last_name', false);
    } else {
      updateValidateWithKeyValue('last_name', true);
    }

    setValidator();
  }

  updateProfileEmailValidation() {
    if (!Utils.validateEmail(emailController.text)) {
      updateValidateWithKeyValue('email', true);
    } else {
      updateValidateWithKeyValue('email', false);
    }

    setValidator();
  }

  updateProfileContactValidation() {
    if (contactController.text.length == 8) {
      updateValidateWithKeyValue('contact', false);
    } else {
      updateValidateWithKeyValue('contact', true);
    }

    setValidator();
  }

  void updateValidateWithKeyValue(String key, bool value) {
    validate[key] = value;
    update();
  }

  //SUBMIT BUTTON FORM VALIDATION
  validateSubmit() {
    if (!Utils.validateEmail(emailController.text)) {
      updateValidateWithKeyValue("email", true);
    } else {
      updateValidateWithKeyValue("email", false);
    }

    // TRUE MEANS NOT VALIDATED
    if (firstNameController.text.isNotEmpty) {
      updateValidateWithKeyValue("first_name", false);
    } else {
      updateValidateWithKeyValue("first_name", true);
    }

    if (lastNameController.text.isNotEmpty) {
      updateValidateWithKeyValue("last_name", false);
    } else {
      updateValidateWithKeyValue("last_name", true);
    }

    if (dobController.text.isNotEmpty) {
      updateValidateWithKeyValue("dob", false);
    } else {
      updateValidateWithKeyValue("dob", true);
    }

    if (contactController.text.length != 8) {
      updateValidateWithKeyValue("contact", true);
    } else {
      updateValidateWithKeyValue("contact", false);
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

  //BUTTON CLICK
  void submit() {
    print("VALID API: $isValid");
    if (isValid) {
      if (Utils.isInternetConnected() != null) {
        Get.offAllNamed(EmployeeProfileWizardTwoScreen.pageId, arguments: {
          'firstName': firstNameController.text,
          'middleName': middleNameController.text,
          'lastName': lastNameController.text,
          'dob': dobController.text,
          'email': emailController.text,
          'phone': contactController.text,
          'gender': isMale,
          'image': image,
        });
      } else {
        errorMessage("Please connect to the network");
      }
    } else {
      //IF USER DIRECTLY PRESSES BUTTON WITHOUT INSERTING DATA
      validateSubmit();
    }
  }

  @override
  void onClose() {
    _unFocus();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    contactController.dispose();
    super.onClose();
  }

  void _unFocus() {
    this.emailFocusNode.unfocus();
  }
}
