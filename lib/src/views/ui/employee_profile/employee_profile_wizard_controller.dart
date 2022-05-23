import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';

import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../utilities/ui_constants.dart';
import '../../../utilities/utils.dart';
import 'package:ebpv2/src/views/ui/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'employee_profile_model.dart';
import 'employee_profile_repository.dart';

class EmployeeProfileWizardTwoXController extends GetxController {
  String date;
  var email;
  List<String> countries;
  String roleValue;
  final EmployeeProfileRepository _repository = EmployeeProfileRepository();
  var currentSelectionIdType = 0;
  var cprErrorMessage = "ID number must be all numeric and 9-15 digits long.";
  var passportErrorMessage = "ID number must be 4-15 characters long.";
  bool idTypeVisible = true;
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

  var currentSelectionMaritalType = 0;

  Map<int, Widget> maritalType = {
    0: Text(
      "Single",
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    1: Text(
      'Married',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
  };

  var currentSelectionChildren = 0;
  Map<int, Widget> childrenType = {
    0: Text(
      "Yes",
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    1: Text(
      'No',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
  };
  bool isSwitched = false;
  TextEditingController idNumberController, addressController;
  bool isValidWizardTwo = false;
  String selectedCountry;
  String firstName, lastName, dob, phone, middleName, gender;
  var token;
  File image;

  @override
  void onInit() {
    super.onInit();
    countries = Constants.baseCountries;
    idNumberController = TextEditingController();
    addressController = TextEditingController();
    resetValidateWizardTwo();
    if (Get.arguments != null) {
      firstName = Get.arguments['firstName'];
      lastName = Get.arguments['lastName'];
      middleName = Get.arguments['middleName'];
      dob = Get.arguments['dob'];
      email = Get.arguments['email'];
      phone = Get.arguments['phone'];
      gender = Get.arguments['gender'];
      image = Get.arguments['image'];
    }
  }

  // CHILDREN SELECTION SEGMENT
  setChildrenSegmentState(int index) {
    currentSelectionChildren = index;
    update();
  }

  // MARITAL TYPE SELECTION SEGMENT
  setMaritalTypeSegmentState(int index) {
    currentSelectionMaritalType = index;
    update();
  }

  //ID TYPE SELECTION SEGMENT
  setIdTypeSegmentState(int index) {
    currentSelectionIdType = index;
    if (currentSelectionIdType == 0) {
      idTypeVisible = true;
    } else {
      idTypeVisible = false;
    }
    update();
  }

  //WIZARD TWO
  toggleSwitch(bool value) {
    if (isSwitched == false) {
      isSwitched = true;
      print('Switch Button is ON');
      update();
    } else {
      isSwitched = false;
      print('Switch Button is OFF');
      update();
    }
  }

  //ON NATIONALITY SELECTION
  onNationalitySelection(String value) {
    print("Selection Value is $value");
    if (value.isNotEmpty) {
      selectedCountry = value;
    }
    update();
  }

  void setValidatorWizardTwo() {
    bool continueAPICall = true;
    isValidWizardTwo = true;
    validateWizardTwo.forEach((key, value) {
      if (value == true) {
        continueAPICall = false;
        isValidWizardTwo = false;
      }
    });
  }

  Map<String, bool> validateWizardTwo = {};

  void resetValidateWizardTwo() {
    validateWizardTwo = {
      "id_number": false,
      "address": false,
    };
    update();
  }

  void updateValidateWizardTwoWithKeyValue(String key, bool value) {
    validateWizardTwo[key] = value;
    update();
  }

  updateIdTypeValidation() {
    if (idTypeVisible) {
      if (idNumberController.text.length >= 9 &&
          idNumberController.text.length < 15) {
        updateValidateWizardTwoWithKeyValue('id_number', false);
      } else {
        updateValidateWizardTwoWithKeyValue('id_number', true);
      }
    } else {
      if (idNumberController.text.length >= 4 &&
          idNumberController.text.length < 15) {
        updateValidateWizardTwoWithKeyValue('id_number', false);
      } else {
        updateValidateWizardTwoWithKeyValue('id_number', true);
      }
    }

    setValidatorWizardTwo();
  }

  updateAddressValidation() {
    if (addressController.text.isNotEmpty) {
      updateValidateWizardTwoWithKeyValue('address', false);
    } else {
      updateValidateWizardTwoWithKeyValue('address', true);
    }
    setValidatorWizardTwo();
  }

  //SUBMIT BUTTON FORM VALIDATION
  validateSubmitWizardTwo() {
    if (idTypeVisible) {
      if (idNumberController.text.length >= 9 &&
          idNumberController.text.length < 15) {
        print("Clicked false");
        updateValidateWizardTwoWithKeyValue('id_number', false);
      } else {
        print("Clicked true");
        updateValidateWizardTwoWithKeyValue('id_number', true);
      }
    } else {
      if (idNumberController.text.length >= 4 &&
          idNumberController.text.length < 15) {
        updateValidateWizardTwoWithKeyValue('id_number', false);
      } else {
        updateValidateWizardTwoWithKeyValue('id_number', true);
      }
    }

    if (addressController.text.isNotEmpty) {
      updateValidateWizardTwoWithKeyValue('address', false);
    } else {
      updateValidateWizardTwoWithKeyValue('address', true);
    }

    setValidatorWizardTwo();
  }

  void submitWizardTwo() {
    print("VALID API: $isValidWizardTwo");
    if (isValidWizardTwo) {
      if (Utils.isInternetConnected() != null) {
        saveProfile();
      } else {
        errorMessage("Please connect to the network");
      }
    } else {
      //IF USER DIRECTLY PRESSES BUTTON WITHOUT INSERTING DATA
      validateSubmitWizardTwo();
    }
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print("TOKEN $token");
  }

  saveProfile() async {
    var saveProfileData = {
      "ID": 0,
      "FirstName": firstName,
      "MiddleName": middleName,
      "LastName": lastName,
      "Gender": gender,
      "Nationality": selectedCountry.toString(),
      "DateOfBirth": dob,
      "CorporateEmail": email,
      "MobileNumber": phone,
      "Address": addressController.text,
      "IdentityID": idNumberController.text,
      "PassportID": idNumberController.text,
      "Subscribed": isSwitched
    };
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.saveProfile(saveProfileData, token);
    Get.back();
    if (result is SuccessState) {
      if (result.value is EmployeeProfileResponse) {
        var profileResponse = result.value.employeeProfileModel;
        Get.offAllNamed(AppRoutes.DASHBOARD);
        print("Success Profile Saving");
        successMessage("Success Saving Profile");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  // uploadPhoto() async {
  //   await getToken();
  //   Utils.showProgressDialog(Get.context, '', 'Loading...');
  //   Result result = await _repository.uploadPhoto(image, token);
  //   Get.back();
  //   if (result is SuccessState) {
  //     print("Success List");
  //   } else if (result is ErrorState) {
  //     errorMessage(result.msg.toString());
  //   }
  // }

  @override
  void onClose() {
    _unFocus();
    idNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  void _unFocus() {}
}
