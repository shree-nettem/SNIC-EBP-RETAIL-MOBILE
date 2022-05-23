import 'dart:io';

import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../../utilities/ui_constants.dart';
import '../../../../utilities/utils.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/dependent_list/employee_dependent_screen.dart';
import 'package:ebpv2/src/views/ui/employee_profile/employee_profile_model.dart';
import 'package:ebpv2/src/views/ui/employee_profile/employee_profile_repository.dart';
import 'employee_dashboard_profile_repository.dart';
import 'employee_dashboard_profile_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EmployeeDashboardProfileXController extends GetxController {
  File image;
  String profilePic;
  var fullName;
  final picker = ImagePicker();
  final EmployeeDashboardProfileRepository _repository =
      EmployeeDashboardProfileRepository();
  final EmployeeProfileRepository _employeeProfileRepository =
      EmployeeProfileRepository();
  var token;
  EmployeeDashboardProfileResponse employeeDashboardProfileResponse;
  TextEditingController dobController,
      firstNameController,
      middleNameController,
      lastNameController,
      contactController,
      emailController,
      personalEmailController,
      secondaryContactController,
      addressController,
      monthlyIncomeController,
      ibanController,
      iedController,
      dledController,
      passportIdController;
  var emailFocusNode = FocusNode();
  var firstNameFocusNode = FocusNode();
  var middleNameFocusNode = FocusNode();
  var lastNameFocusNode = FocusNode();
  var personalEmailFocusNode = FocusNode();
  var primaryContactFocusNode = FocusNode();
  var secondaryContactFocusNode = FocusNode();
  var addressFocusNode = FocusNode();
  var incomeFocusNode = FocusNode();
  var ibanFocusNode = FocusNode();
  var idNumberFocusNode = FocusNode();
  var passportIdFocusNode = FocusNode();
  var iedFocusNode = FocusNode();
  var dledFocusNode = FocusNode();

  bool isValid = false;
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
  var isMale;

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
  var selectedDate = DateTime.now();
  var date, ieDate, dleDate;
  List<String> countries;
  List<String> occupation;
  List<String> banks;
  var selectedOccupation;
  var selectedBank;

  bool isSwitched = false;

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
  var currentSelectionIdType = 0;
  TextEditingController idNumberController;
  var cprErrorMessage = "ID number must be all numeric and 9-15 digits long.";
  var passportErrorMessage = "ID number must be 4-15 characters long.";
  var selectedCountry;
  List<Dependents> dependents = [];

  @override
  void onInit() {
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    contactController = TextEditingController();
    emailController = TextEditingController();
    dobController = TextEditingController();
    personalEmailController = TextEditingController();
    secondaryContactController = TextEditingController();
    addressController = TextEditingController();
    idNumberController = TextEditingController();
    monthlyIncomeController = TextEditingController();
    ibanController = TextEditingController();
    iedController = TextEditingController();
    dledController = TextEditingController();
    passportIdController = TextEditingController();
    resetValidate();
    fetchCustomerProfile();
    countries = Constants.baseCountries;
    occupation = Constants.baseOccupation;
    banks = Constants.baseBanks;
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  fetchCustomerProfile() async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.getCustomerProfile(token);
    if (result is SuccessState) {
      if (result.value is EmployeeDashboardProfileResponse) {
        var customerProfileResponse = result.value;
        employeeDashboardProfileResponse = customerProfileResponse;
        profileData();
      }
    } else if (result is ErrorState) {
      Get.back();
      errorMessage(result.msg.toString());
    }
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

  //MAP PROFILE DATA TO USER CONTROLS
  void profileData() {
    var firstName = employeeDashboardProfileResponse.firstName + " " ?? null;
    var middleName = employeeDashboardProfileResponse.middleName != null
        ? employeeDashboardProfileResponse.middleName + " "
        : " ";
    var lastName = employeeDashboardProfileResponse.lastName != null
        ? employeeDashboardProfileResponse.lastName
        : " ";
    firstNameController.text = firstName ?? null;
    middleNameController.text = middleName;
    lastNameController.text = lastName;
    fullName = firstName + middleName + lastName;
    genderSelection = (employeeDashboardProfileResponse.gender == "m") ? 0 : 1;
    currentSelectionMaritalType =
        (employeeDashboardProfileResponse.maritalStatus == 1) ? 0 : 1;
    profilePic =
        Constants.BASE_FILE_URL + employeeDashboardProfileResponse.photo;
    date = employeeDashboardProfileResponse.dateOfBirth ?? null;

    DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(date);
    dobController.text = DateFormat("yyyy-MM-dd").format(tempDate);

    var email = employeeDashboardProfileResponse.email;
    emailController.text = email ?? null;

    addressController.text = employeeDashboardProfileResponse.address ?? null;
    secondaryContactController.text =
        employeeDashboardProfileResponse.otherContactNumber ?? null;
    personalEmailController.text =
        employeeDashboardProfileResponse.personalEmail ?? null;

    selectedCountry = employeeDashboardProfileResponse.nationality ?? null;
    selectedOccupation = employeeDashboardProfileResponse.position ?? null;
    selectedBank = employeeDashboardProfileResponse.bank ?? null;
    isSwitched = employeeDashboardProfileResponse.subscribed;

    var primaryContactNumber =
        employeeDashboardProfileResponse.mobileNumber ?? null;
    contactController.text = primaryContactNumber;

    var monthlyIncome = employeeDashboardProfileResponse.salary ?? null;
    monthlyIncomeController.text = monthlyIncome.toString();

    var iban = employeeDashboardProfileResponse.iBAN ?? null;
    ibanController.text = iban;

    var identityNumber = employeeDashboardProfileResponse.identityID ??
        employeeDashboardProfileResponse.passportID;
    idNumberController.text = identityNumber;

    ieDate = employeeDashboardProfileResponse.identityExpiryDate ?? null;

    if (ieDate != null) {
      DateTime tempIEDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(ieDate);
      iedController.text = DateFormat("yyyy-MM-dd").format(tempIEDate);
    }

    dleDate = employeeDashboardProfileResponse.licenceExpiryDate ?? null;

    if (dleDate != null) {
      DateTime tempIEDate =
          new DateFormat("yyyy-MM-ddThh:mm:ss").parse(dleDate);
      dledController.text = DateFormat("yyyy-MM-dd").format(tempIEDate);
    }

    dependents = employeeDashboardProfileResponse.dependents ?? [];

    Get.back();
    update();
  }

  //SET GENDER SEGMENT STATE
  setGenderSegmentState(var index) {
    genderSelection = index;
    isMale = (genderSelection == 0) ? "m" : "f";
    update();
  }

  // MARITAL TYPE SELECTION SEGMENT
  setMaritalTypeSegmentState(int index) {
    currentSelectionMaritalType = index;
    update();
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera(n) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print('Image selected from camera.');
      uploadPhoto(n);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery(n) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print('Image selected from Gallery.');
      uploadPhoto(n);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  test() {
    print("Button Pressed!");
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

  toggleSwitch(bool value) {
    if (isSwitched == false) {
      isSwitched = true;
      update();
    } else {
      isSwitched = false;
      update();
    }
  }

  //ON NATIONALITY SELECTION
  onNationalitySelection(String value) {
    if (value.isNotEmpty) {
      selectedCountry = value;
    }
    update();
  }

  //ON OCCUPATION SELECTION
  onOccupationSelection(String value) {
    if (value.isNotEmpty) {
      selectedOccupation = value;
    }
    update();
  }

  //ON BANK SELECTION
  onBankSelection(String value) {
    if (value.isNotEmpty) {
      selectedBank = value;
    }
    update();
  }

  //VALIDATION FORM
  Map<String, bool> validate = {};

  void resetValidate() {
    validate = {
      "first_name": false,
      "last_name": false,
      "email": false,
      "address": false,
      "dob": false,
      "contact": false,
      "id_number": false,
    };
    update();
  }

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

  updateProfileEmailValidation() {
    if (!Utils.validateEmail(emailController.text)) {
      updateValidateWithKeyValue('email', true);
    } else {
      updateValidateWithKeyValue('email', false);
    }

    setValidator();
  }

  updateProfileContactValidation() {
    if (contactController.text.length < 0) {
      updateValidateWithKeyValue('contact', false);
    } else {
      updateValidateWithKeyValue('contact', true);
    }

    setValidator();
  }

  updateAddressValidation() {
    if (addressController.text.isNotEmpty) {
      updateValidateWithKeyValue('address', false);
    } else {
      updateValidateWithKeyValue('address', true);
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
    bool continueAPICall = true;
    isValid = true;
    validate.forEach((key, value) {
      if (value == true) {
        continueAPICall = false;
        isValid = false;
      }
    });
  }

  void submit() {
    print("VALID API: $isValid");
    if (isValid || (fullName.isNotEmpty && emailController.text.isNotEmpty)) {
      if (Utils.isInternetConnected() != null) {
        saveProfile();
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

    if (addressController.text.isNotEmpty) {
      updateValidateWithKeyValue('address', false);
    } else {
      updateValidateWithKeyValue('address', true);
    }

    if (contactController.text.length < 0) {
      updateValidateWithKeyValue('contact', false);
    } else {
      updateValidateWithKeyValue('contact', true);
    }

    if (dobController.text.isNotEmpty) {
      updateValidateWithKeyValue("dob", false);
    } else {
      updateValidateWithKeyValue("dob", true);
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

    setValidator();
  }

  saveProfile() async {
    var saveProfileData = {
      "ID": 0,
      "Name": fullName,
      "FirstName": firstNameController.text,
      "MiddleName": middleNameController.text,
      "LastName": lastNameController.text,
      "Gender": (genderSelection == 0) ? "m" : "f",
      "MaritalStatus": currentSelectionMaritalType,
      "IDType": currentSelectionIdType,
      "IdentityID": idNumberController.text,
      "PassportID": passportIdController.text,
      "Nationality": selectedCountry.toString(),
      "DateOfBirth": dobController.text,
      "Department": null,
      "Position": selectedOccupation,
      "CorporateEmail": emailController.text,
      "PersonalEmail": personalEmailController.text,
      "MobileNumber": contactController.text,
      "OtherContactNumber": "+973",
      "Address": addressController.text,
      "Salary": monthlyIncomeController.text,
      "IBAN": ibanController.text,
      "Bank": selectedBank,
      "PrimaryEmail": 1,
      "IdentityExpiryDate": ieDate,
      "LicenceExpiryDate": dleDate,
      "Subscribed": isSwitched,
    };

    print("SAVE INFO " + saveProfileData.toString());

    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result =
        await _employeeProfileRepository.saveProfile(saveProfileData, token);
    Get.back();
    if (result is SuccessState) {
      if (result.value is EmployeeProfileResponse) {
        print("Success Profile Saving");
        successMessage("Success Saving Profile");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  //UPLOAD PHOTO
  uploadPhoto(n) async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result =
        await _employeeProfileRepository.uploadPhoto(image, token, n);
    Get.back();
    if (result is SuccessState) {
      print("Photo uploaded");
      successMessage("File uploaded");
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  dependentScreen() {
    Get.toNamed(EmployeeDependentScreen.pageId, arguments: {
      'dependents': dependents,
    });
  }

  @override
  void onClose() {
    _unFocus();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    personalEmailController.dispose();
    secondaryContactController.dispose();
    addressController.dispose();
    idNumberController.dispose();
    monthlyIncomeController.dispose();
    ibanController.dispose();
    iedController.dispose();
    dledController.dispose();
    passportIdController.dispose();
    super.onClose();
  }

  void _unFocus() {
    this.emailFocusNode.unfocus();
    this.firstNameFocusNode.unfocus();
    this.middleNameFocusNode.unfocus();
    this.lastNameFocusNode.unfocus();
    this.personalEmailFocusNode.unfocus();
    this.primaryContactFocusNode.unfocus();
    this.secondaryContactFocusNode.unfocus();
    this.addressFocusNode.unfocus();
    this.incomeFocusNode.unfocus();
    this.ibanFocusNode.unfocus();
    this.idNumberFocusNode.unfocus();
    this.passportIdFocusNode.unfocus();
    this.iedFocusNode.unfocus();
    this.dledFocusNode.unfocus();
  }
}
