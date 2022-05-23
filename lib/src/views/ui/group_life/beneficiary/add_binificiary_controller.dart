import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/beneficiary_controller.dart';
import 'package:ebpv2/src/views/ui/group_life/models/get_benificiaries_model.dart';
import 'package:ebpv2/src/views/ui/startup/country_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddBinificiaryXController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController addressController,
      idNumberController,
      nameController,
      contactNumController,
      dateController,
      // relationController,
      percentageController,
      gaurdianAddressController,
      gaurdianIdNumberController,
      gaurdiaNameController,
      gaurdiaContactNumController,
      gaurdiaDateController,
      gaurdiaNationalityController,
      gaurdiaEmailController;
  // gaurdiaRelationController;

  RxBool isBenificiaryMinor = false.obs;
  List<bool> isGenderStatusSelected;
  List<String> genderTypes = ['Male', 'Female'];
  List<String> relationTypes = [
    'main_relation'.tr,
    'son'.tr,
    'daughter'.tr,
    'spouse'.tr
  ];
  String gaurdianNationality = "Select";
  String selectedCountryCode = "+973", gaurdianCountryCode = "+973";
  String selectedRelation, selectedGaurdianRelation;
  String gaurdianGender;
  int currentIndex;
  int selectedBenificiaryID = 0;

  RxBool hasBeneficiaryMobibleNumberAdded = true.obs;
  RxBool hasGaurdianMobibleNumberAdded = true.obs;

  PhoneNumber beneficiaryNumber = PhoneNumber(isoCode: 'BH', dialCode: "+973");
  PhoneNumber gaurdianNumber = PhoneNumber(isoCode: 'BH', dialCode: "+973");
  @override
  void onInit() {
    addressController = TextEditingController();
    idNumberController = TextEditingController();
    // relationController = TextEditingController();
    nameController = TextEditingController();
    contactNumController = TextEditingController();
    dateController = TextEditingController();
    percentageController = TextEditingController();

    gaurdianAddressController = TextEditingController();
    gaurdianIdNumberController = TextEditingController();
    // gaurdiaRelationController = TextEditingController();
    gaurdiaNameController = TextEditingController();
    gaurdiaContactNumController = TextEditingController();
    gaurdiaDateController = TextEditingController();
    gaurdiaNationalityController = TextEditingController();
    gaurdiaEmailController = TextEditingController();

    isGenderStatusSelected = [true, false];
    gaurdianGender = genderTypes[0];

    selectedRelation = relationTypes[0];
    selectedGaurdianRelation = relationTypes[0];

    super.onInit();
  }

  getKeyboardHeight() {
    print(MediaQuery.of(Get.context).viewInsets.bottom);
  }

  // Get textfileds data
  getFullName() => nameController.text;

  DateTime getDob() => DateFormat("dd-MM-yyyy").parse(dateController.text);

  getContactNumber() => contactNumController.text;
  // getContactNumber() => contactNumController.text;

  getIDNumbber() => idNumberController.text;

  getAddress() => addressController.text;

  getPercentage() => percentageController.text;

  getRelation() => selectedRelation;

  getGaurdianFullName() => gaurdiaNameController.text;

  DateTime getGaurdianDob() =>
      DateFormat("dd-MM-yyyy").parse(gaurdiaDateController.text);

  getGaurdianContactNumber() => gaurdiaContactNumController.text;
  // getGaurdianContactNumber() => gaurdiaContactNumController.text;

  getGaurdianIDNumbber() => gaurdianIdNumberController.text;

  getGaurdianAddress() => gaurdianAddressController.text;

  getGaurdianRelation() => selectedGaurdianRelation;

  getGaurdianNationality() => gaurdianNationality;

  getGaurdianGender() => gaurdianGender;

  getGaurdianEmail() => gaurdiaEmailController.text;

  void setBenificiaryTextfields(LifeBenificiaries bineficiaryData, int index) {
    hasBeneficiaryMobibleNumberAdded.value = true;
    hasGaurdianMobibleNumberAdded.value = true;

    if (bineficiaryData != null) {
      currentIndex = index;
      selectedBenificiaryID = bineficiaryData.beneficiaryId;
      nameController.text = bineficiaryData.beneficiaryName;
      dateController.text = DateFormat('dd-MM-yyyy')
          .format(bineficiaryData.beneficiaryDateOfBirth);

      idNumberController.text = bineficiaryData.beneficiaryIdNo;
      addressController.text = bineficiaryData.beneficiaryAddress;

      try {
        selectedRelation = relationTypes.firstWhere((element) =>
            element == bineficiaryData.beneficiaryRelation ?? relationTypes[0]);
      } catch (e) {
        selectedRelation = relationTypes[0];
      }

      percentageController.text =
          bineficiaryData.beneficiaryPercentage.toStringAsFixed(3);

      minorChecking(bineficiaryData.beneficiaryDateOfBirth);

      // AppHelper()
      //     .getMobileNumber(bineficiaryData.beneficiaryMobile)
      //     .then((value) => contactNumController.text = value);
      // AppHelper()
      //     .getMobileNumber(bineficiaryData.beneficiaryMobile,
      //         requiredDailCode: true)
      //     .then((value) => selectedCountryCode = value == '' ? "+973" : value);

      contactNumController.text = bineficiaryData.beneficiaryMobile;
      print(bineficiaryData.beneficiaryMobileCountryCode);
      CountryCodeResult beneficiaryCountry = Constants.baseCountryCodesFromApi
          .firstWhere((element) =>
              element.dialCode ==
                  bineficiaryData.beneficiaryMobileCountryCode ??
              "+973");
      beneficiaryNumber = PhoneNumber(
          isoCode: beneficiaryCountry.code,
          dialCode: bineficiaryData.beneficiaryMobileCountryCode ?? "+973",
          phoneNumber: bineficiaryData.beneficiaryMobile);

      selectedCountryCode =
          bineficiaryData.beneficiaryMobileCountryCode ?? "+973";

      if (isBenificiaryMinor.value) {
        gaurdiaNameController.text = bineficiaryData.guardianName ?? "";
        gaurdiaDateController.text = bineficiaryData.guardianDateOfBirth != null
            ? DateFormat('dd-MM-yyyy')
                .format(bineficiaryData.guardianDateOfBirth)
            : "";
        gaurdiaContactNumController.text = bineficiaryData.guardianMobile ?? "";
        gaurdianIdNumberController.text = bineficiaryData.guardianIdNo ?? "";
        gaurdianAddressController.text = bineficiaryData.guardianAddress ?? "";
        try {
          selectedGaurdianRelation = relationTypes.firstWhere((element) =>
              element == bineficiaryData.guardianRelation ?? relationTypes[0]);
        } catch (e) {
          selectedGaurdianRelation = relationTypes[0];
        }

        // selectedGaurdianRelation = bineficiaryData.guardianRelation ?? "";
        gaurdiaNationalityController.text = bineficiaryData.guardianNationality;
        gaurdianNationality = Constants.baseCountries
                .contains(bineficiaryData.guardianNationality)
            ? bineficiaryData.guardianNationality
            : "Select";
        gaurdiaEmailController.text = bineficiaryData.guardianEmail ?? "";
        CountryCodeResult gaurdianCountry = Constants.baseCountryCodesFromApi
            .firstWhere((element) =>
                element.dialCode == bineficiaryData.guardianMobileCountryCode ??
                "+973");
        gaurdianNumber = PhoneNumber(
            isoCode: gaurdianCountry.code,
            dialCode: bineficiaryData.guardianMobileCountryCode ?? "+973",
            phoneNumber: bineficiaryData.guardianMobile);
        gaurdianCountryCode =
            bineficiaryData.guardianMobileCountryCode ?? "+973";
        if (bineficiaryData.guardianGender.toString().toUpperCase() ==
            "FEMALE") {
          switchGenderStatus(1);
        } else {
          switchGenderStatus(0);
        }
      } else {
        clearGaurdianTextfields();
      }
    } else {
      isBenificiaryMinor.value = false;
      currentIndex = null;
      selectedBenificiaryID = 0;
      clearBenificiaryTextfields();
      clearGaurdianTextfields();
    }

    update();
  }

  clearBenificiaryTextfields() {
    addressController.clear();
    idNumberController.clear();
    // relationController.clear();
    nameController.clear();
    contactNumController.clear();
    dateController.clear();
    percentageController.clear();
    selectedCountryCode = "+973";
    beneficiaryNumber = PhoneNumber(isoCode: 'BH', dialCode: "+973");
  }

  clearGaurdianTextfields() {
    gaurdianAddressController.clear();
    gaurdianIdNumberController.clear();
    // gaurdiaRelationController.clear();
    gaurdiaNameController.clear();
    gaurdiaContactNumController.clear();
    gaurdiaDateController.clear();
    gaurdiaNationalityController.clear();
    gaurdiaEmailController.clear();
    gaurdianCountryCode = "+973";
    gaurdianNationality = "Select";
    gaurdianNumber = PhoneNumber(isoCode: 'BH', dialCode: "+973");

    isGenderStatusSelected = [true, false];
    gaurdianGender = genderTypes[0];
  }

  Future<String> selectDate(BuildContext context, DateTime selectedDate,
      {bool isMinor = false, bool islastDateToday = true}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate:
          islastDateToday ? DateTime.now() : DateTime(DateTime.now().year - 18),
    );
    if (picked != null) {
      if (isMinor) minorChecking(picked);
      return DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void minorChecking(DateTime selectedDate) {
    final presentDate = DateTime.now();

    final years = (presentDate.difference(selectedDate).inDays / 365).floor();

    if (years < 18) {
      isBenificiaryMinor.value = true;
    } else {
      isBenificiaryMinor.value = false;
    }
    update();
  }

  switchGenderStatus(index) {
    for (int i = 0; i < isGenderStatusSelected.length; i++) {
      isGenderStatusSelected[i] = i == index;
      if (i == index) gaurdianGender = genderTypes[i];
    }
    update();
  }

  void setNationality(String nationality) {
    this.gaurdianNationality = nationality;
  }

  void setRelation(String relation) {
    this.selectedRelation = relation;
  }

  void setGaurdianRelation(String relation) {
    this.selectedGaurdianRelation = relation;
  }

  void saveBenificiary() {
    LifeBenificiaries newData = LifeBenificiaries(
        beneficiaryId: selectedBenificiaryID,
        customerId: 176,
        companyId: 9,
        beneficiaryName: getFullName(),
        beneficiaryDateOfBirth: getDob(),
        beneficiaryMobile: getContactNumber(),
        beneficiaryAddress: getAddress(),
        beneficiaryPercentage: double.parse(getPercentage()),
        guardianName: isBenificiaryMinor.value ? getGaurdianFullName() : null,
        guardianIdNo: isBenificiaryMinor.value ? getGaurdianIDNumbber() : null,
        guardianRelation:
            isBenificiaryMinor.value ? getGaurdianRelation() : null,
        guardianDateOfBirth: isBenificiaryMinor.value ? getGaurdianDob() : null,
        guardianAddress: isBenificiaryMinor.value ? getGaurdianAddress() : null,
        guardianMobile:
            isBenificiaryMinor.value ? getGaurdianContactNumber() : null,
        guardianGender: isBenificiaryMinor.value ? getGaurdianGender() : null,
        guardianNationality:
            isBenificiaryMinor.value ? getGaurdianNationality() : null,
        beneficiaryIdNo: getIDNumbber(),
        beneficiaryRelation: getRelation(),
        guardianEmail: isBenificiaryMinor.value ? getGaurdianEmail() : null,
        beneficiaryMobileCountryCode: selectedCountryCode,
        guardianMobileCountryCode:
            isBenificiaryMinor.value ? gaurdianCountryCode : null);

    if (currentIndex != null) {
      Get.find<BeneficiaryXController>().totalBenificiaries[currentIndex] =
          newData;
    } else {
      Get.find<BeneficiaryXController>().totalBenificiaries.add(newData);
    }

    Get.find<BeneficiaryXController>().changeBenificiaryUI();
    Get.find<BeneficiaryXController>().isSaveOn.value = true;
  }

  void deleteBeneficiary() {
    Get.find<BeneficiaryXController>()
        .totalBenificiaries
        .removeAt(currentIndex);

    Get.find<BeneficiaryXController>().changeBenificiaryUI();
    Get.find<BeneficiaryXController>().isSaveOn.value = true;
  }

  @override
  void onClose() {
    addressController.dispose();
    idNumberController.dispose();
    // relationController.dispose();
    nameController.dispose();
    contactNumController.dispose();
    dateController.dispose();
    percentageController.dispose();

    gaurdianAddressController.dispose();
    gaurdianIdNumberController.dispose();
    // gaurdiaRelationController.dispose();
    gaurdiaNameController.dispose();
    gaurdiaContactNumController.dispose();
    gaurdiaDateController.dispose();
    gaurdiaEmailController.dispose();
    gaurdiaNationalityController.dispose();

    super.onClose();
  }
}
