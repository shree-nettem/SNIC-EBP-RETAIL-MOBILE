import 'dart:convert';
import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/dependent_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_model.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/country_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddDependentFormXController extends GetxController {
  PhoneNumber number = PhoneNumber(isoCode: 'BH');
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  TextEditingController addressController,
      idNumberController,
      nameController,
      contactNumController,
      dateController,
      relationController;

  String selectedCountryCode = "+973";
  RxBool hasDependentMobibleNumberAdded = true.obs;

  TextEditingController middleNameController,
      lastNameController,
      passportIDController,
      emailController,
      idExpireDateController,
      driverLicenseController;

  List<bool> relationStatusSelected;
  List<bool> idTypeStatusSelected;
  String nationality, idType, date;

  String customerName, relation;

  int currentIndex;
  int selectedDependenceID = 0;
  int selectedRelation = 0, selectedIdType = 0;
  List<String> countries = [];
  var token;
  File cprFile, passPortFile;
  final picker = ImagePicker();
  bool isSavedClicked = false;
  var passport;
  var cpr;

  @override
  void onInit() {
    countries = Constants.baseCountries;
    addressController = TextEditingController();
    idNumberController = TextEditingController();
    relationController = TextEditingController();
    nameController = TextEditingController();
    contactNumController = TextEditingController();
    dateController = TextEditingController();

    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    passportIDController = TextEditingController();
    emailController = TextEditingController();
    idExpireDateController = TextEditingController();
    driverLicenseController = TextEditingController();

    relationStatusSelected = [false, false, false];
    idTypeStatusSelected = [false, false];
    // getCountries();
    getToken();

    super.onInit();
  }

  /* LOAD COUNTRY FROM THE LOCAL JSON FILE */
  getCountries() async {
    // String data = await rootBundle.loadString('assets/json/country_list.json');
    // Map<String, dynamic> mapData =
    //     new Map<String, dynamic>.from(json.decode(data));
    // countries = mapData['countries']
    //     .map((data) => CountryResult.fromJson(data))
    //     .toList()
    //     .cast<CountryResult>();

    update();
  }

  void setFullName() {
    customerName = nameController.text +
        " ${middleNameController.text}" +
        " " +
        lastNameController.text;
    update();
  }

  switchRelationStatus(index) {
    for (int i = 0; i < relationStatusSelected.length; i++) {
      relationStatusSelected[i] = i == index;
    }
    selectedRelation = index + 1;
    relation = Get.find<DependentXController>().updateRelation(index + 1);
    debugPrint("IS STATUS $selectedRelation");
    update();
  }

  switchIdTypeStatus(index) {
    for (int i = 0; i < idTypeStatusSelected.length; i++) {
      idTypeStatusSelected[i] = i == index;
    }
    debugPrint("IS STATUS $idTypeStatusSelected");
    selectedIdType = index + 1;
    debugPrint("IS STATUS $selectedIdType");
    update();
  }

  void setNationality(String nationality) {
    this.nationality = nationality;
  }

  void setBeneficiaryTextFields(Dependents dependent) {
    hasDependentMobibleNumberAdded.value = true;
    relationStatusSelected = [false, false, false];
    idTypeStatusSelected = [false, false];
    if (dependent != null) {
      // currentIndex = index;
      selectedDependenceID = dependent.iD;
      nameController.text = dependent.firstName;
      dateController.text = Utils.formattedDate(dependent.dateOfBirth);
      // DateFormat('dd-MM-yyyy').format(dependentData.dateOfBirth);
      idExpireDateController.text = dependent.identityExpiryDate != null
          ? Utils.formattedDate(dependent.identityExpiryDate)
          : "";
      driverLicenseController.text = dependent.licenceExpiryDate != null
          ? dependent.licenceExpiryDate
          : "";
      contactNumController.text = dependent.mobileNumber;
      emailController.text = dependent.personalEmail;
      number = PhoneNumber(isoCode: 'BH', phoneNumber: dependent.mobileNumber);
      selectedCountryCode = dependent.countryCode ?? "+973";
      idNumberController.text = dependent.identityID ?? "";
      addressController.text = dependent.address;
      dependent.relationshipType != null
          ? relationStatusSelected[dependent.relationshipType - 1] = true
          : relationStatusSelected[0] = true;
      dependent.iDType != null
          ? idTypeStatusSelected[dependent.iDType - 1] = true
          : idTypeStatusSelected[0] = true;

      selectedRelation = dependent.relationshipType ?? 1;
      selectedIdType = dependent.iDType ?? 1;
      relation = Get.find<DependentXController>()
          .updateRelation(dependent.relationshipType);
      print(relation);
      middleNameController.text = dependent.middleName ?? "";
      lastNameController.text = dependent.lastName ?? "";
      passportIDController.text = dependent.passportID ?? "";
      debugPrint(dependent.nationality);
      passport =
          dependent.documents.isNotEmpty ? dependent.documents[0].file : "";
      if (dependent.documents.isNotEmpty && dependent.documents.length > 1)
        cpr = dependent.documents[1].file;
      print(passport);
      if (dependent.nationality.isNotEmpty) {
        int i;
        if (dependent.nationality == "bahrain") {
          var chosenCountry = "Bahraini";
          i = countries.indexWhere((element) =>
              element.toLowerCase() == chosenCountry.toString().toLowerCase());

          nationality = countries[i];
          debugPrint("NATIONALITY $i}");
        } else {
          i = countries.indexWhere((element) =>
              element.toLowerCase() ==
              dependent.nationality.toString().toLowerCase());

          nationality = countries[i];
        }
      } else {
        debugPrint("NATIONALITY ");
        nationality = dependent.nationality ?? "Select";
      }
      setFullName();
    } else {
      currentIndex = null;
      selectedDependenceID = 0;
      relationStatusSelected[0] = false;
      idTypeStatusSelected[0] = true;
      relation = Get.find<DependentXController>().updateRelation(1);
      clearDependentTextfields();
    }
  }

  clearDependentTextfields() {
    addressController.clear();
    idNumberController.clear();
    relationController.clear();
    nameController.clear();
    contactNumController.clear();
    dateController.clear();
    middleNameController.clear();
    lastNameController.clear();
    passportIDController.clear();
    emailController.clear();
    idExpireDateController.clear();
    driverLicenseController.clear();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print("TOKEN $token");
  }

  String dob;

  void setDOB(String date) {
    debugPrint("DOB $date");
    this.dob = date;
  }

  saveDependent(bool isEdit) async {
    var dateOfBirth = Utils.serverFormattedDate(dateController.text);

    var requestMap = {
      "ID": isEdit ? selectedDependenceID : 0,
      "FirstName": nameController.text,
      "MiddleName": middleNameController.text,
      "LastName": lastNameController.text,
      "DateOfBirth": dateController.text != "" ? dateOfBirth : "",
      // "RelationshipType": selectedRelation,
      "Nationality": nationality,
      "Gender": "m",
      "Address": "",
      "Department": "",
      "MaritalStatus": "1",
      "IDType": 1,
      "RelationshipType": selectedRelation != null ? selectedRelation : 1,
      "IdentityID": idNumberController.text,
      "PassportID": passportIDController.text,
      "PersonalEmail": emailController.text,
      "MobileNumber": contactNumController.text,
      "CountryCode": selectedCountryCode,
      "OtherContactNumber": "",
      "IdentityExpiryDate": idExpireDateController.text != ""
          ? Utils.serverFormattedDate(idExpireDateController.text)
          : "",
      "LicenceExpiryDate": "",
      "Subscribed": true,
      "MailingAddressTown": "",
      "MailingAddressBlock": "",
      "MailingAddressRoad": "",
      "MailingAddressHouse": "",
      "HomeAddressTown": "",
      "HomeAddressBlock": "",
      "HomeAddressRoad": "",
      "HomeAddressHouse": "",
    };

    debugPrint("Relation $requestMap");

    Result result = await DioClient().post('Customer/SaveMember', requestMap,
        token: token, isPostData: true);
    print(result.toString());

    if (result is SuccessState) {
      var jsonData = result.value;
      selectedDependenceID = jsonData["ID"];
      //  UPLOAD FILE IF THERE IS ANY
      if (cprFile != null && passPortFile != null) {
        uploadFile(type: "UploadID", isCPR: true);
        uploadFile(type: "UploadPassport");
      } else if (cprFile != null) {
        uploadFile(type: "UploadID", isCPR: true);
      } else if (passPortFile != null) {
        uploadFile(type: "UploadPassport");
      } else {
        getCustomerDetailsFromAPI();
        Get.find<DependentXController>().addDependentClicked();
        // Get.back();
      }
      debugPrint("Successfully saved dependent");
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  deleteDependent() async {
    Result result = await DioClient().post(
        'Customer/DeleteMember?id=$selectedDependenceID', {},
        token: token, isPostData: false);
    print(result.toString());

    if (result is SuccessState) {
      getCustomerDetailsFromAPI();
      successMessage("Successfully Deleted!");
      Get.find<DependentXController>().addDependentClicked();
      // Get.offAllNamed(AppRoutes.DASHBOARD);
    } else if (result is ErrorState) {
      errorMessage("Some error occured while deleting member!");
    }
  }

  getCustomerDetailsFromAPI({bool isLoading = false}) async {
    Result result =
        await DioClient().get('Customer/Details2', token, isLoading: isLoading);
    if (result is SuccessState) {
      var jsonData = CustomerProfileModel.fromJson(result.value);
      if (jsonData is CustomerProfileModel) {
        Get.find<DependentXController>().dependents = jsonData;
        Get.find<DependentXController>().update();
        // customerDetails = jsonData;
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery({bool isCPR = false}) async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    final pickedFile = File(result.files.single.path);
    if (pickedFile != null) {
      if (isCPR) {
        cprFile = File(pickedFile.path);
        uploadFile(type: "UploadID", isCPR: isCPR);
      } else {
        passPortFile = File(pickedFile.path);
        uploadFile(type: "UploadPassport");
      }
      print('Image selected from Gallery.');
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
        cprFile = File(pickedFile.path);
        uploadFile(type: "UploadID", isCPR: isCPR);
      } else {
        passPortFile = File(pickedFile.path);
        uploadFile(type: "UploadPassport");
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
        cprFile = File(pickedFile.path);
        uploadFile(type: "UploadID", isCPR: isCPR);
      } else {
        passPortFile = File(pickedFile.path);
        uploadFile(type: "UploadPassport");
      }
      print('Image selected from Gallery.');
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  /* UPLOAD PASSPORT OR CPR */
  void uploadFile({String type, bool isCPR = false}) async {
    var endPoint = 'Customer/$type?dependentID=$selectedDependenceID';
    print(endPoint);
    var image = isCPR ? cprFile : passPortFile;
    Result result = await DioClient().postFile(image, endPoint, token);

    if (result is SuccessState) {
      var data = List<String>.from(json.decode(result.value).map((x) => x));
      if (isCPR) {
        cpr = data[0];
      } else {
        passport = data[0];
      }
    } else if (result is ErrorState) {
      errorMessage("Error occured while uploading file");
    }
    Get.back();
  }

  @override
  void onClose() {
    addressController.dispose();
    idNumberController.dispose();
    relationController.dispose();
    nameController.dispose();
    contactNumController.dispose();
    dateController.dispose();

    middleNameController.dispose();
    lastNameController.dispose();
    passportIDController.dispose();
    emailController.dispose();
    idExpireDateController.dispose();
    driverLicenseController.dispose();

    super.onClose();
  }

  void dependentSaveClicked() {
    isSavedClicked = true;
    update();
  }
}
