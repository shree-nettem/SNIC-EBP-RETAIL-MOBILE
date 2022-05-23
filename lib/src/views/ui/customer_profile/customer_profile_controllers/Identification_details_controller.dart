import 'dart:convert';
import 'dart:io';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_model.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/country_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class IdentificationDetailsXController extends GetxController {
  List<String> openAccountReasonOptions;
  List<String> IdTypeList;
  List<String> countries = [];
  List<String> countryList = [];
  String chosenValue;
  File image;
  final picker = ImagePicker();

  TextEditingController iDNumberController,
      iDExpirationDateController,
      passportNumberController,
      licenseExpirationDateController;

  String nationality, IdType;

  CustomerProfileModel customerDetails;
  final CustomerProfileController profileController = Get.find();

  void setNationality(String nationality) {
    this.chosenValue = nationality;
    update();
  }

  void setIdType(String IdType) {
    this.IdType = IdType;
  }

  getNationality() => nationality;

  getIdType() => IdType;

  getIDNumber() => iDNumberController.text;

  getIDExpirationDate() => iDExpirationDateController.text;

  getPassportNumber() => passportNumberController.text;

  getLicenseExpirationDate() => licenseExpirationDateController.text;

  final formKey = GlobalKey<FormState>();
  bool isIdentificationVisible = false;

  Future<String> selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  int getidType() {
    switch (IdType) {
      case "CPR":
        return 1;
        break;
      case "Passport":
        return 2;
        break;
      default:
        return 0;
    }
  }

  SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
  bool isLoading = false;
  var token;

  @override
  void onInit() {
    iDNumberController = TextEditingController();
    iDExpirationDateController = TextEditingController();
    passportNumberController = TextEditingController();
    licenseExpirationDateController = TextEditingController();
    IdTypeList = ["Select", "CPR", "Passport"];
    countries = Constants.baseCountries;
    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    token = await _sharedPreferencesHelper.getAccessToken;
    debugPrint("TOKEN $token");
  }

  setData(bool isVisible) {
    if (!isIdentificationVisible) {
      customerDetails = profileController.customerDetails;

      var chosenCountry = customerDetails.details.nationality;
      IdType = IdTypeList[customerDetails.details.iDType];
      iDNumberController.text = customerDetails.details.identityID;

      iDExpirationDateController.text =
          customerDetails.details.identityExpiryDate != null
              ? Utils.formattedDate(customerDetails.details.identityExpiryDate)
              : "";
      passportNumberController.text = customerDetails.details.passportID;
      licenseExpirationDateController.text =
          customerDetails.details.licenceExpiryDate != null
              ? Utils.formattedDate(customerDetails.details.licenceExpiryDate)
              : "";

      getCountries(chosenCountry);

      isIdentificationVisible = true;
      update();
    } else {
      var file = customerDetails.details.documents[0].file;
      debugPrint("ALREADY SET $file");
    }
  }

  /* LOAD COUNTRY FROM THE LOCAL JSON FILE */
  getCountries(chosenCountry) async {
    // String data = await rootBundle.loadString('assets/json/country_list.json');
    // Map<String, dynamic> mapData =
    //     new Map<String, dynamic>.from(json.decode(data));
    // countries = mapData['countries']
    //     .map((data) => CountryResult.fromJson(data))
    //     .toList()
    //     .cast<CountryResult>();

    if (chosenCountry == "bahrain") {
      chosenCountry = "Bahrain";
    }

    if (countries.contains(chosenCountry)) {
      chosenValue = chosenCountry;
    } else {
      chosenValue = "select".tr;
    }
    // int i = countries.indexWhere((element) =>
    //     element.name.toLowerCase() == chosenCountry.toString().toLowerCase());

    // debugPrint("COUNTRY SET $i $chosenValue");

    // chosenValue = countries[i].name ?? "Bahrain";

    update();
  }

  /* SAVE IDENTITY INFO TO THE SERVER */
  saveIdentityInfo() {
    var identityInfoRequestMap = {
      "Nationality": chosenValue,
      "IDType": IdType,
      "IdentityExpiryDate": iDExpirationDateController.text,
      "PassportID": passportNumberController.text,
      "LicenceExpiryDate": licenseExpirationDateController.text,
      "IdentityID": iDNumberController.text
    };

    debugPrint("IDENTITY $identityInfoRequestMap");
    postIdentityInfo(identityInfoRequestMap);
  }

  /*  POST IDENTITY INFORMATION */
  postIdentityInfo(identityInfoRequestMap) async {
    Result result = await DioClient().post(
      'Customer/SaveProfileIdentification',
      identityInfoRequestMap,
      token: token,
      isPostData: true,
    );
    if (result is SuccessState) {
      updateCustomerIdentityDetails();
      successMessage("Successfully updated!");
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  /* UPDATE CUSTOMER IDENTITY DETAILS */
  updateCustomerIdentityDetails() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;

    customerDetails.details.nationality = getNationality();
    customerDetails.details.iDType = getidType();
    customerDetails.details.identityID = iDNumberController.text;
    customerDetails.details.passportID = passportNumberController.text;
    customerDetails.details.identityExpiryDate =
        iDExpirationDateController.text;
    customerDetails.details.licenceExpiryDate =
        licenseExpirationDateController.text;
    update();
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery({bool isCPR = false}) async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    final pickedFile = File(result.files.single.path);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print('Image selected from Gallery.');
      uploadFile(isCPR: isCPR);
    } else {
      print('No image selected.');
    }
    update();
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera({bool isCPR = false}) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (isCPR) {
        image = File(pickedFile.path);
        uploadFile(isCPR: isCPR);
      } else {
        image = File(pickedFile.path);
        uploadFile(isCPR: isCPR);
      }
      print('Image selected from Gallery.');
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //GET IMAGE FROM THE Gallery
  Future getImageFromGallery({bool isCPR = false}) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isCPR) {
        image = File(pickedFile.path);
        uploadFile(isCPR: isCPR);
      } else {
        image = File(pickedFile.path);
        uploadFile(isCPR: isCPR);
      }
      print('Image selected from Gallery.');
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  /* UPLOAD PASSPORT OR CPR */
  void uploadFile({bool isCPR = false}) async {
    var endPoint = isCPR ? "Customer/UploadID" : '/Customer/UploadPassport';
    Result result = await DioClient().postFile(image, endPoint, token);
    if (result is SuccessState) {
      getCustomerDetailsFromAPI(isLoading: false);
      successMessage("File uploaded");
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  getCustomerDetailsFromAPI({bool isLoading = true}) async {
    Result result =
        await DioClient().get('Customer/Details2', token, isLoading: isLoading);
    if (result is SuccessState) {
      var jsonData = CustomerProfileModel.fromJson(result.value);
      if (jsonData is CustomerProfileModel) {
        customerDetails = jsonData;
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  saveUserBasicData() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;
    var requestMap = {
      "ID": customerDetails.details.iD,
      "FirstName": customerDetails.details.firstName,
      "MiddleName": customerDetails.details.middleName ?? "",
      "LastName": customerDetails.details.lastName,
      "IdentityID": iDNumberController.text ?? "",
      "IDType": getIdType() != 0 ? getidType() : null,
      "DateOfBirth": customerDetails.details.dateOfBirth,
      "IBAN": customerDetails.details.iBAN,
      "Department": customerDetails.details.department,
      "Gender": customerDetails.details.gender,
      "MobileNumber": customerDetails.details.mobileNumber,
      "Salary": customerDetails.details.salary,
      "PassportID": passportNumberController.text ?? "",
      "Position": customerDetails.details.position,
      "MaritalStatus": customerDetails.details.maritalStatus,
      "PersonalEmail": customerDetails.details.personalEmail,
      "Nationality": this.nationality,
      "Bank": customerDetails.details.bank,
      "OtherContactNumber": customerDetails.details.otherContactNumber,
      "PrimaryEmail": customerDetails.details.primaryEmail,
      "CorporateEmail": customerDetails.details.corporateEmail,
      "IdentityExpiryDate": iDExpirationDateController.text != null
          ? DateFormat('dd-MM-yyyy').parse(iDExpirationDateController.text)
          : null,
      "LicenceExpiryDate": licenseExpirationDateController.text != null
          ? DateFormat('dd-MM-yyyy').parse(licenseExpirationDateController.text)
          : null,
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

    Get.find<CustomerProfileController>().saveProfileData(requestMap);
  }
}
