import 'dart:convert';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/country_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../utilities/constants.dart';

class CompleteProfileController extends GetxController {
  var benefitResponseBody;
  TextEditingController emailController;
  TextEditingController firstNameController,
      middleNameController,
      lastNameController,
      dateOfBirthController,
      placeOfBirthController,
      nationalityController,
      idNumberController,
      passportNumberController,
      sourceOfIncomeController,
      addressController,
      residentController,
      occupationController,
      employeeNameController,
      employeeAddressController;
  bool isSavingGhady = false;
  bool isGeneralInsurance = false;
  bool viewMedicalBenefits = false;
  bool existingCustomer = false;
  int userId;
  List<CountryResult> countries = [];
  String countryName = "";
  List<String> sourceOfIncomeOptions = [
    "Salary",
    "Inheritance",
    "Business Ownership",
    "Investments"
  ];
  List<String> monthlyIncomeTypes = [
    "< BD 300",
    "BD 300 – BD 1000",
    "BD 1001 – BD 2500",
    "BD 2501 – BD 5000",
    "> BD 5000"
  ];
  String selectedSourceOfIncome = "Salary";
  String selectedMonthlyIncome;
  int sourceOfIncomeIndex = 0;

  String dropdownValue;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    dateOfBirthController = TextEditingController();
    placeOfBirthController = TextEditingController();
    nationalityController = TextEditingController();
    idNumberController = TextEditingController();
    passportNumberController = TextEditingController();
    addressController = TextEditingController();
    residentController = TextEditingController();
    occupationController = TextEditingController();
    employeeNameController = TextEditingController();
    employeeAddressController = TextEditingController();
    if (Get.arguments != null) {
      benefitResponseBody = Get.arguments[0]["body"];
      userId = Get.arguments[0]["user_id"];
      existingCustomer = Get.arguments[0]["existing_customer"];
      residentController.text = "Yes";
      getCountries();
      setData();
    }
  }

  setData() {
    String firstName =
        benefitResponseBody[Constants.benefitIGEFields]["firstNameEn"] ?? "";
    String middleName =
        benefitResponseBody[Constants.benefitIGEFields]["middleName1En"] ?? " ";
    String lastName =
        benefitResponseBody[Constants.benefitIGEFields]["lastNameEn"] ?? " ";
    String gender =
        benefitResponseBody[Constants.benefitIGEFields]["gender"] ?? " ";
    String dateOfBirth =
        benefitResponseBody[Constants.benefitIGEFields]["dateOfBirth"] ?? " ";
    String telephoneNumber = benefitResponseBody[Constants.benefitIGEFields]
            ["telephoneNumber"] ??
        " ";
    String email =
        benefitResponseBody[Constants.benefitIGEFields]["email"] ?? " ";
    String addressType =
        benefitResponseBody[Constants.benefitIGEFields]["addressType"] ?? " ";
    String placeOfBirth =
        benefitResponseBody[Constants.benefitIGEFields]["placeOfBirth"] ?? " ";
    String nationality =
        benefitResponseBody[Constants.benefitIGEFields]["nationality"] ?? " ";
    String passportNumber = benefitResponseBody[Constants.benefitIGEFields]
            ["passportNumber"] ??
        " ";
    String idNumber =
        benefitResponseBody[Constants.benefitIGEFields]["idNumber"] ?? " ";
    int flatNumber =
        benefitResponseBody[Constants.benefitIGEFields]["flatNumber"] ?? " ";
    int buildingNumber = benefitResponseBody[Constants.benefitIGEFields]
            ["buildingNumber"] ??
        " ";
    String buildingAlpha =
        benefitResponseBody[Constants.benefitIGEFields]["buildingAlpha"];
    int roadNumber =
        benefitResponseBody[Constants.benefitIGEFields]["roadNumber"] ?? " ";
    int blockNumber =
        benefitResponseBody[Constants.benefitIGEFields]["blockNumber"] ?? " ";
    String occupation =
        benefitResponseBody[Constants.benefitIGEFields]["occupation"];
    String employeeName =
        benefitResponseBody[Constants.benefitIGEFields]["nameOfEmployer"];
    // String employeeAddress = benefitResponseBody["IGAFeilds"]["occupation"];

    if (occupation != null) {
      occupationController.text = occupation;
    }

    employeeNameController.text = employeeName != null ? employeeName : "";

    String buildingAlphaValue =
        buildingAlpha.isNotEmpty ? "-" + buildingAlpha : "";
    debugPrint("ALPHA $buildingAlphaValue");
    String address = "Flat " +
        flatNumber.toString() +
        ", " +
        "Building " +
        buildingNumber.toString() +
        buildingAlphaValue +
        ", " +
        "Road " +
        roadNumber.toString() +
        ", " +
        "Block " +
        blockNumber.toString();
    emailController.text = email;
    firstNameController.text = firstName;
    middleNameController.text = middleName;
    lastNameController.text = lastName;
    dateOfBirthController.text = dateOfBirth;
    placeOfBirthController.text = placeOfBirth;
    nationalityController.text = nationality;
    idNumberController.text = idNumber;
    passportNumberController.text = passportNumber;
    addressController.text = address;

    update();
    debugPrint("BENEFIT $benefitResponseBody");
  }

  /* LOAD COUNTRY FROM THE LOCAL JSON FILE */
  getCountries() async {
    String data = await rootBundle.loadString('assets/json/country_list.json');
    Map<String, dynamic> mapData =
        new Map<String, dynamic>.from(json.decode(data));
    countries = mapData['countries']
        .map((data) => CountryResult.fromJson(data))
        .toList()
        .cast<CountryResult>();

    int i = countries.indexWhere((element) =>
        element.value.toLowerCase() ==
        nationalityController.text.toString().toLowerCase());
    countryName = countries[i].name;
    nationalityController.text = countryName;
    update();
  }

  /* ON SAVING GHADY */
  void onSavingGhady() {
    if (isSavingGhady) {
      isSavingGhady = false;
    } else {
      isSavingGhady = true;
    }
    update();
  }

  /* ON GENERAL INSURANCE */
  void onGeneralInsurance() {
    if (isGeneralInsurance) {
      isGeneralInsurance = false;
    } else {
      isGeneralInsurance = true;
    }
    update();
    debugPrint("IS CHECKED $isGeneralInsurance");
  }

  /* ON VIEWING MEDICAL BENEFITS */
  void onViewingMedicalBenefits() {
    if (viewMedicalBenefits) {
      viewMedicalBenefits = false;
    } else {
      viewMedicalBenefits = true;
    }
    update();
    debugPrint("IS CHECKED $viewMedicalBenefits");
  }

  void navigateToCompleteRegistration() {
    var registerBody = {
      "SavingWithGhady": isSavingGhady,
      "GeneralInsurance": isGeneralInsurance,
      "ViewingMedicalBenefits": viewMedicalBenefits,
      "SourceOfIncome": selectedSourceOfIncome ?? "",
      "MonthlyIncome": selectedMonthlyIncome ?? "",
      "IdNumber": idNumberController.text
    };
    debugPrint("Source $registerBody");
    Get.toNamed(AppRoutes.COMPLETE_REGISTRATION, arguments: [
      {
        "register_body": registerBody,
        "user_id": userId,
        "existing_customer": existingCustomer
      }
    ]);
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    middleNameController.dispose();
    dateOfBirthController.dispose();
    placeOfBirthController.dispose();
    nationalityController.dispose();
    idNumberController.dispose();
    passportNumberController.dispose();
    addressController.dispose();
    residentController.dispose();
    occupationController.dispose();
    employeeNameController.dispose();
    employeeAddressController.dispose();
  }
}
