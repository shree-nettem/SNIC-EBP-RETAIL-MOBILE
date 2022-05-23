import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../startup/country_code_model.dart';

class BasicInfoXController extends GetxController {
  List<String> mStatus = ["Salaried", "SelfEmployed"];
  String label = "Salaried";
  TextEditingController emailController,
      passwordController,
      dateController,
      nameController,
      contactNumController,
      alternateNumController,
      occupationController;

  TextEditingController middleNameController, lastNameController;

  List<bool> isMartialStatusSelected;
  List<bool> isGenderStatusSelected;
  final formKey = GlobalKey<FormState>();
  CustomerProfileModel details;
  String email, password, date, name, contactNumber, occupation, countryCode;

  String initialCountry = 'BH';
  PhoneNumber alternateNumber;
  String selectedCountryCode;

  String selectedGender = 'm';
  int selectedMartialStatus = 1;
  bool isLoading = false;
  bool hasNetworkError = false;
  String token = '';

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dateController = TextEditingController();
    nameController = TextEditingController();
    contactNumController = TextEditingController();
    alternateNumController = TextEditingController();
    occupationController = TextEditingController();

    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    isMartialStatusSelected = [true, false];
    isGenderStatusSelected = [true, false];
    selectedCountryCode = "+973";
    alternateNumber = PhoneNumber(isoCode: 'BH', dialCode: "+973");
    // number = PhoneNumber(isoCode: 'BH');
    getToken();
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    var accessToken = await _sharedPreferencesHelper.getAccessToken;
    token = accessToken;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setOccupation(String occupation) {
    this.email = occupation;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setDate(String date) {
    this.date = date;
  }

  void setName(String name) {
    this.name = name;
  }

  void setContactNumber(String contactNumber) {
    this.contactNumber = contactNumber;
  }

  getEmail() => emailController.text;

  getPassword() => passwordController.text;

  getDate() => dateController.text;

  getName() => nameController.text;

  getContactNumber() => contactNumController.text;

  getAlternateNumber() => alternateNumController.text;

  getOccupation() => occupationController.text;

  addingDataAfterApi() {
    details = Get.find<CustomerProfileController>().customerDetails;
    nameController.text = details.details.firstName ?? "";
    middleNameController.text = details.details.middleName ?? "";
    lastNameController.text = details.details.lastName ?? "";
    emailController.text = details.details.personalEmail ?? "";
    countryCode = details.details.countryCode ?? "+973";
    debugPrint("COUNTRY_CODE $countryCode");
    if (details.details.dateOfBirth != null) {
      dateController.text = Utils.formattedDate(details.details.dateOfBirth);
    }

    contactNumController.text = details.details.mobileNumber;
    alternateNumController.text = details.details.otherContactNumber;

    try {
      CountryCodeResult secondaryCountry = Constants.baseCountryCodesFromApi
          .firstWhere((element) =>
              element.dialCode ==
                  details.details.otherContactNumberCountryCode ??
              "+973");
      alternateNumber = PhoneNumber(
          isoCode: secondaryCountry.code,
          dialCode: details.details.otherContactNumberCountryCode ?? "+973",
          phoneNumber: details.details.otherContactNumber);

      selectedCountryCode = details.details.countryCode ?? "+973";
    } catch (e) {}

    occupationController.text = details.details.position ?? '';
    if (details.details.gender != "f") {
      isGenderStatusSelected = [true, false];
      selectedGender = "m";
    } else {
      selectedGender = "f";
      isGenderStatusSelected = [false, true];
    }
    if (details.details.maritalStatus != 2) {
      isMartialStatusSelected = [true, false];
    } else {
      selectedMartialStatus = 2;
      isMartialStatusSelected = [false, true];
    }
    update();
  }

  void setFullName() {
    Get.find<CustomerProfileController>().setCustomerName(nameController.text +
        " ${middleNameController.text}" +
        " " +
        lastNameController.text);
  }

  switchMaritalStatus(index) {
    for (int i = 0; i < isMartialStatusSelected.length; i++) {
      isMartialStatusSelected[i] = i == index;
    }
    selectedMartialStatus = index + 1;
    debugPrint("IS STATUS $isMartialStatusSelected");
    update();
  }

  switchGenderStatus(index) {
    for (int i = 0; i < isGenderStatusSelected.length; i++) {
      isGenderStatusSelected[i] = i == index;
    }
    index == 0 ? selectedGender = "m" : selectedGender = "f";
    debugPrint("IS STATUS $isGenderStatusSelected");
    update();
  }

  /* SAVE BASIC INFORMATION */
  saveBasicInformation() {
    String fullName = nameController.text + " " + middleNameController.text ??
        "" + lastNameController.text ??
        "";
    var basicInfoRequestMap = {
      "FirstName": fullName,
      "MiddleName": "",
      "LastName": "",
      "PersonalEmail": emailController.text,
      "Gender": selectedGender,
      "MaritalStatus": selectedMartialStatus,
      "DateOfBirth": dateController.text,
      "MobileNumber": contactNumController.text,
      "Position": occupationController.text,
      "OtherContactNumber": alternateNumController.text,
      "OtherContactNumberCountryCode": selectedCountryCode ?? "+973",
    };

    debugPrint("BASIC_REQUEST_MAP $basicInfoRequestMap");
    // details.details.otherContactNumber = alternateNumController.text;
    // details.details.otherContactNumberCountryCode =
    //     selectedCountryCode ?? "+973";

    postBasicInfo(basicInfoRequestMap);
  }

  /* POST THE DATA TO SERVER */
  postBasicInfo(basicInfoRequestMap) async {
    isLoading = true;
    update();
    Result result = await DioClient().post(
      'Customer/SaveProfileBasicInformation',
      basicInfoRequestMap,
      token: token,
      isPostData: true,
    );
    isLoading = false;
    update();
    if (result is SuccessState) {
      successMessage("Successfully updated!");
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  saveUserBasicData() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;

    var requestMap = {
      "ID": customerDetails.details.iD,
      "FirstName": nameController.text ?? "",
      "MiddleName": middleNameController.text ?? "",
      "LastName": lastNameController.text ?? "",
      "Address": "Sanabis",
      "IBAN": customerDetails.details.iBAN,
      "IDType": customerDetails.details.iDType,
      "DateOfBirth": dateController.text,
      "Department": customerDetails.details.department,
      "Gender": selectedGender,
      "MobileNumber": contactNumController.text,
      "Salary": customerDetails.details.salary,
      "PassportID": customerDetails.details.passportID,
      "IdentityID": customerDetails.details.identityID,
      "Position": occupationController.text ?? "",
      "MaritalStatus": selectedMartialStatus,
      "PersonalEmail": customerDetails.details.personalEmail,
      "IDType": 1,
      "Nationality": customerDetails.details.nationality,
      "Bank": customerDetails.details.bank,
      "OtherContactNumber": alternateNumController.text,
      "OtherContactNumberCountryCode": selectedCountryCode ?? "+973",
      "PrimaryEmail": customerDetails.details.primaryEmail,
      "CorporateEmail": emailController.text,
      "IdentityExpiryDate": customerDetails.details.identityExpiryDate,
      "LicenceExpiryDate": customerDetails.details.licenceExpiryDate,
      "Subscribed": customerDetails.details.subscribed,
      "MobileNumberOTP": "",
      "CorporateEmailOTP": "",
      "PersonalEmailOTP": "",
      "MailingAddressTown": customerDetails.details.mailingAddressTown,
      "MailingAddressBlock": customerDetails.details.mailingAddressBlock,
      "MailingAddressRoad": customerDetails.details.mailingAddressRoad,
      "MailingAddressHouse": customerDetails.details.mailingAddressHouse,
      "HomeAddressTown": customerDetails.details.homeAddressTown,
      "HomeAddressBlock": customerDetails.details.homeAddressBlock,
      "HomeAddressRoad": customerDetails.details.homeAddressRoad,
      "HomeAddressHouse": customerDetails.details.homeAddressHouse
    };

    print(requestMap);

    Get.find<CustomerProfileController>().saveProfileData(requestMap);
  }

  void updatedCountryCode(String val) {
    selectedCountryCode = val ?? "+973";
    update();
  }

  @override
  void onClose() {
    super.onClose();
    middleNameController.dispose();
    lastNameController.dispose();
  }
}
