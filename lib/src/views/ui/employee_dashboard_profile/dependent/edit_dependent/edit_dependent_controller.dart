import 'dart:io';

import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../../../utilities/ui_constants.dart';
import '../../../../../utilities/utils.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/add_dependent/dependent_profile_repository.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/employee/employee_dashboard_profile_response.dart';
import 'package:ebpv2/src/views/ui/employee_profile/employee_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditDependentXController extends GetxController {
  var _dependents = Dependents();
  File image;
  final picker = ImagePicker();
  var token;
  TextEditingController firstNameController,
      middleNameController,
      lastNameController,
      passportIdController,
      idNumberController,
      dobController,
      emailController,
      contactController,
      iedController,
      dledController;
  var firstNameFocusNode = FocusNode();
  var middleNameFocusNode = FocusNode();
  var lastNameFocusNode = FocusNode();
  var idNumberFocusNode = FocusNode();
  var passportIdFocusNode = FocusNode();
  var dobFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var contactFocusNode = FocusNode();
  var dledFocusNode = FocusNode();
  var iedFocusNode = FocusNode();
  var selectedDate = DateTime.now();
  bool isValid = false;
  var currentSelectionMaritalType;
  Map<int, Widget> relationshipType = {
    1: Text(
      "Spouse",
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    2: Text(
      'Son',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    3: Text(
      'Daughter',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
  };
  var relationshipSelection;
  var currentSelectionIdType = 1;
  var cprErrorMessage = "ID number must be all numeric and 9-15 digits long.";
  var passportErrorMessage = "ID number must be 4-15 characters long.";
  bool idTypeVisible = true;
  Map<int, Widget> identityType = {
    1: Text(
      "CPR",
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
    2: Text(
      'Passport No',
      style: textStyleWithoutColor(MediumFontSize, FontWeight.normal),
    ),
  };
  List<String> countries;
  var selectedCountry;
  var date, dleDate, ieDate;
  String profilePic;
  var id;
  var fullName;
  final _dependentProfileRepository = DependentProfileRepository();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      _dependents = Get.arguments['dependent'];

      countries = Constants.baseCountries;
      firstNameController = TextEditingController();
      middleNameController = TextEditingController();
      lastNameController = TextEditingController();
      passportIdController = TextEditingController();
      idNumberController = TextEditingController();
      dobController = TextEditingController();
      emailController = TextEditingController();
      contactController = TextEditingController();
      iedController = TextEditingController();
      dledController = TextEditingController();

      setDependentData();
      getToken();
      resetValidate();
    }
  }

  setDependentData() {
    if (_dependents.photo != null) {
      profilePic = Constants.BASE_FILE_URL + _dependents.photo;
    }

    var firstName = _dependents.firstName ?? "";
    firstNameController.text = firstName;
    var middleName = _dependents.middleName ?? "";
    middleNameController.text = middleName;
    var lastName = _dependents.lastName ?? "";
    lastNameController.text = lastName;

    relationshipSelection = (_dependents.relationshipType == 1)
        ? 1
        : (_dependents.relationshipType == 2)
            ? 2
            : 3;
    currentSelectionIdType = (_dependents.iDType == 1) ? 1 : 2;
    selectedCountry = _dependents.nationality ?? "";
    var idNumber = _dependents.identityID ?? "";
    idNumberController.text = idNumber;

    var passportId = _dependents.passportID ?? "";
    passportIdController.text = passportId;

    date = _dependents.dateOfBirth ?? null;

    DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(date);
    dobController.text = DateFormat("yyyy-MM-dd").format(tempDate);

    ieDate = _dependents.identityExpiryDate ?? null;

    if (ieDate != null) {
      DateTime tempIEDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(ieDate);
      iedController.text = DateFormat("yyyy-MM-dd").format(tempIEDate);
    }

    dleDate = _dependents.licenceExpiryDate ?? null;

    if (dleDate != null) {
      DateTime tempIEDate =
          new DateFormat("yyyy-MM-ddThh:mm:ss").parse(dleDate);
      dledController.text = DateFormat("yyyy-MM-dd").format(tempIEDate);
    }

    id = _dependents.iD;
    update();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera(picValue) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      uploadMemberPhoto(picValue);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //GET IMAGE FROM THE GALLERY
  //PROFILE_PIC = 1; UPLOAD_ID= 2; UPLOAD_PASSPORT= 3;
  Future getImageGallery(picValue) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      uploadMemberPhoto(picValue);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //ON NATIONALITY SELECTION
  onNationalitySelection(String value) {
    if (value.isNotEmpty) {
      selectedCountry = value;
      FocusScope.of(Get.context).requestFocus(new FocusNode());
    }
    update();
  }

  //SET RELATIONSHIP SEGMENT STATE
  setRelationShipSegmentState(index) {
    relationshipSelection = index;
    update();
  }

  setIdTypeSegmentState(int index) {
    currentSelectionIdType = index;
    if (currentSelectionIdType == 1) {
      idTypeVisible = true;
      //  CPR = 1
    } else {
      idTypeVisible = false;
      //  PASSPORT = 2
    }
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

  //SHOW IDENTITY EXPIRATION DATE PICKER
  selectIEDate() async {
    await showDatePicker(
      context: Get.context,
      initialDate: selectedDate,
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2031, 1),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != selectedDate) {
        ieDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(pickedDate);
        iedController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      }
    });
    update();
  }

  //SHOW DL EXPIRATION DATE PICKER
  selectDLEDDate() async {
    await showDatePicker(
      context: Get.context,
      initialDate: selectedDate,
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2031, 1),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != selectedDate) {
        dleDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(pickedDate);
        dledController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      }
    });
    update();
  }

  Map<String, bool> validate = {};

  void resetValidate() {
    validate = {
      "first_name": false,
      "last_name": false,
      "id_number": false,
      "dob": false,
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
    if (lastNameController.text.isNotEmpty) {
      updateValidateWithKeyValue('last_name', false);
    } else {
      updateValidateWithKeyValue('last_name', true);
    }

    setValidator();
  }

  updateIdTypeValidation() {
    if (idTypeVisible) {
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

  void setValidator() {
    isValid = true;
    validate.forEach((key, value) {
      if (value == true) {
        isValid = false;
      }
    });
  }

  //BUTTON CLICK
  void updateMemberProfile() {
    print("VALID API: $isValid");
    if (isValid ||
        (firstNameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            idNumberController.text.isNotEmpty &&
            dobController.text.isNotEmpty)) {
      if (Utils.isInternetConnected() != null) {
        saveEditedMemberProfile();
      } else {
        errorMessage("Please connect to the network");
      }
    } else {
      //IF USER DIRECTLY PRESSES BUTTON WITHOUT INSERTING DATA
      validateSubmit();
    }
  }

  //SUBMIT BUTTON FORM VALIDATION
  validateSubmit() {
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

    if (idTypeVisible) {
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

    if (dobController.text.isNotEmpty) {
      updateValidateWithKeyValue("dob", false);
    } else {
      updateValidateWithKeyValue("dob", true);
    }

    setValidator();
  }

  saveEditedMemberProfile() async {
    var firstName = firstNameController.text ?? "";
    var middleName = middleNameController.text ?? null;
    var lastName = lastNameController.text ?? "";

    var fullName = firstName + " " + middleName + lastName;
    var saveMemberProfileData = {
      "ID": id,
      "Name": fullName,
      "FirstName": firstName,
      "MiddleName": middleName,
      "LastName": lastName,
      "Nationality": selectedCountry,
      "IDType": currentSelectionIdType,
      "IdentityID": idNumberController.text,
      "PassportID": passportIdController.text,
      "DateOfBirth": date,
      "PersonalEmail": emailController.text,
      "MobileNumber": contactController.text,
      "RelationshipType": relationshipSelection,
      "IdentityExpiryDate": ieDate,
      "LicenceExpiryDate": dleDate,
    };
    print("SAVE EDITED MEMBER INFO " + saveMemberProfileData.toString());
    Utils.showProgressDialog(Get.context, '', 'Saving...');
    ResultV1 result = await _dependentProfileRepository.saveMemberProfile(
        saveMemberProfileData, token);
    Get.back();
    if (result is SuccessState) {
      if (result.value is EmployeeProfileResponse) {
        var dependentId = result.value.employeeProfileModel.iD.toString();
        print("Success Profile Saving " + dependentId);
        successMessage("Successfully added!");
        _unFocus();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  //UPLOAD PHOTO
  uploadMemberPhoto(picValue) async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _dependentProfileRepository.uploadPhoto(
        image, token, picValue, id);
    Get.back();
    if (result is SuccessState) {
      print("Photo uploaded");
      successMessage("Photo uploaded!");
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  deleteMemberProfile() {
    Utils.showAlertDialog(Get.context, "Are you sure?", "Confirm",
        title: "Delete", cancelTitle: "Cancel", okHandler: () {
      print("Delete Pressed! " + id.toString());
      deleteProfile();
    });
    update();
  }

  //UPLOAD PHOTO
  deleteProfile() async {
    Utils.showProgressDialog(Get.context, '', 'Processing...');
    ResultV1 result =
        await _dependentProfileRepository.deleteProfile(token, id.toString());
    Get.back();
    if (result is SuccessState) {
      print("Deleted");
      successMessage("Successfully deleted!");
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  @override
  void onClose() {
    _unFocus();
    firstNameController.dispose();
    lastNameController.dispose();
    middleNameController.dispose();
    passportIdController.dispose();
    idNumberController.dispose();
    emailController.dispose();
    contactController.dispose();
    iedController.dispose();
    dledController.dispose();
    super.onClose();
  }

  void _unFocus() {
    this.firstNameFocusNode.unfocus();
    this.middleNameFocusNode.unfocus();
    this.idNumberFocusNode.unfocus();
    this.passportIdFocusNode.unfocus();
    this.dobFocusNode.unfocus();
    this.emailFocusNode.unfocus();
    this.contactFocusNode.unfocus();
    this.dledFocusNode.unfocus();
    this.iedFocusNode.unfocus();
  }
}
