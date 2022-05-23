import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/city_list.dart';
import 'package:ebpv2/src/views/ui/motor/model/garage_list.dart';
import 'package:ebpv2/src/views/ui/motor/model/insurance_company_list.dart';
import 'package:ebpv2/src/views/ui/motor/model/make_year.dart';
import 'package:ebpv2/src/views/ui/motor/model/personal_verification.dart';
import 'package:ebpv2/src/views/ui/motor/model/submit_claim_response.dart';
import 'package:ebpv2/src/views/ui/motor/model/vehicle_make.dart';
import 'package:ebpv2/src/views/ui/motor/model/vehicle_model.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'motor_claim_controller.dart';

class MotorClaimDetailsXController extends GetxController {
  List<String> clainAgainst, dealership, claimCountries;
  List<String> accidentTown = ["Select"];
  GarageList garageList;
  List<bool> otherPartInvolved, driverType;
  String token;
  final formKey = GlobalKey<FormState>();
  bool isClaimDetailsSubmitted;
  SubmitClaimResponse response;
  String selectedClainAgainst,
      selectedClaimCountry = "BAHRAIN",
      selectedDealership,
      selectedDriverType;
  RxString selectedAccidentTown = "Select".obs;
  List<VehicleMake> makeList;
  List<ModelDetail> modelList;
  List<String> insuranceCompanyList;
  String vehicleMake = "SELECT", insuranceCompanyName = "SELECT";

  RxString vehicleModel = "SELECT".obs, makeYear = "SELECT".obs;
  final picker = ImagePicker();
  List<String> vehicleMakeList = ["SELECT"],
      vehicleModelList = ["SELECT"],
      makeYearList = ["SELECT"];
  PersonalVerification verification;

  TextEditingController policyReportNumber,
      surveyDate,
      driverName,
      driverDob,
      licenseIssueDate,
      plateNumber,
      policyNumber,
      tpCprNumber,
      tpFirstName,
      tpMiddleName,
      tpLastName,
      tpDob,
      tpRegistrationNumber,
      tpAddress,
      tpContactNumber,
      tpMobileNumber;

/*  bool isPoliceReportUploaded,
      isOwnershipDocumentUploaded,
      isCopyOfIBanUploaded,
      isDrivingLicenceUploaded,
      isCPRUploaded;*/

  SelectVehicleXController controller = Get.find();
  MotorClaimXController _controller = Get.find();

  @override
  void onInit() {
    policyReportNumber = TextEditingController();
    surveyDate = TextEditingController();
    driverName = TextEditingController();
    driverDob = TextEditingController();
    licenseIssueDate = TextEditingController();
    plateNumber = TextEditingController();
    policyNumber = TextEditingController();
    tpCprNumber = TextEditingController();
    tpFirstName = TextEditingController();
    tpMiddleName = TextEditingController();
    tpLastName = TextEditingController();
    tpDob = TextEditingController();
    tpRegistrationNumber = TextEditingController();
    tpAddress = TextEditingController();
    tpContactNumber = TextEditingController();
    tpMobileNumber = TextEditingController();
    claimCountries = ["Select", "BAHRAIN"];
    // accidentTown = ["Select"];
    clainAgainst = ["Select", "At Fault", "Not At Fault", "Unknown Damage"];
    selectedClainAgainst = clainAgainst[0];
    dealership = ["Select"];

    selectedDealership = dealership[0];
    insuranceCompanyList = ["SELECT"];
    otherPartInvolved = [false, false];
    driverType = [false, false];
/*    isPoliceReportUploaded = false;
    isOwnershipDocumentUploaded = false;
    isCopyOfIBanUploaded = false;
    isDrivingLicenceUploaded = false;
    isCPRUploaded = false;*/
    getToken();

    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getVehicleMakeList();
  }

  void setModel(String val) {
    makeYear.value = "SELECT";
    getMakeYear(
        modelList.firstWhere((element) => element.model == val).modelCode);
  }

  void setMake(String claim) {
    vehicleMake = claim;
    makeYear.value = "SELECT";

    getVehicleModle(
        makeList.firstWhere((element) => element.description == claim).code);
  }

  void setInsuranceCompany(String claim) {
    insuranceCompanyName = claim;
  }

  @override
  void onClose() {
    policyReportNumber.dispose();
    surveyDate.dispose();
    driverName.dispose();
    driverDob.dispose();
    licenseIssueDate.dispose();
    plateNumber.dispose();
    policyNumber.dispose();
    tpCprNumber.dispose();
    tpFirstName.dispose();
    tpMiddleName.dispose();
    tpLastName.dispose();
    tpDob.dispose();
    tpRegistrationNumber.dispose();
    tpAddress.dispose();
    tpContactNumber.dispose();
    tpMobileNumber.dispose();
    super.onClose();
  }

  //choose from party involved
  switchPartyInvolved(index) {
    for (int i = 0; i < otherPartInvolved.length; i++) {
      otherPartInvolved[i] = i == index;
    }

    update();
  }

  //driver type
  switchDrivertype(index, MotorClaimXController claimController) {
    for (int i = 0; i < driverType.length; i++) {
      driverType[i] = i == index;
    }
    if (driverType[0]) {
      selectedDriverType = "Holder";
    } else if (driverType[1]) {
      selectedDriverType = "Not Policy Holder";
    }
    claimController.update();
  }

  //get garageDealerShip lookUp list
  void getGarageDealerShip(String policyNumber) async {
    res.Result result = await DioClient()
        .get('Motor/GetGarageList?policyNumber=$policyNumber', token);
    if (result is res.SuccessState) {
      garageList = GarageList.fromJson(result.value);
      dealership.clear();
      dealership = ["Select"];

      dealership.addAll(garageList.result.map((e) => e.label).toList());
      getUserIdentificationStatus();
      if (dealership.contains("Dealership")) {
        selectedDealership = "Dealership";
      }

      getClaimCities();
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //get locations (cities)
  void getClaimCities() async {
    res.Result result = await DioClient().get(
        'Values/MotorCountryLocations?country=$selectedClaimCountry', token);
    if (result is res.SuccessState) {
      var cityList = CityList.fromJson(result.value);
      accidentTown = ["Select"];
      selectedAccidentTown.value = accidentTown[0];
      accidentTown.addAll(cityList.result.map((e) => e.description).toList());

      update();
    } else if (result is res.ErrorState) {
      // Get.back();
      errorMessage(result.msg);
    }
  }

  //get locations (cities)
  void getAccidentLocations({String quotationNumber}) async {
    res.Result result = await DioClient().get(
        'Motor/GetAccidentLocation?quotationNumber=${controller.policyDetails.quotationNumber}',
        token);
    if (result is res.SuccessState) {
      claimCountries = List<String>.from(result.value.map((x) => x)).toList();
      update();
    } else if (result is res.ErrorState) {
      // Get.back();
      errorMessage(result.msg);
    }
  }

  //submit claim for police report
  void submitClaim(String claimType) async {
    String postDealershipValue;

    try {
      postDealershipValue = garageList.result
          .firstWhere((element) => element.label == selectedDealership)
          .value;
    } catch (e) {
      postDealershipValue = selectedDealership;
    }
    var body = {
      "PolicyNumber": controller.selectedPolicy.policyNumber,
      "DateOfLoss": controller.selectedAccidentDate,
      "PoliceReportDate": "",
      "PoliceReportNumber": policyReportNumber.text,
      "LossDescription": "Loss",
      "Responsibility": selectedClainAgainst.removeAllWhitespace,
      "AccidentLocationCountry": selectedClaimCountry,
      "AccidentLocation": selectedAccidentTown,
      "DriverType": selectedDriverType,
      "DriverName": driverName.text.isEmpty ? "" : driverName.text,
      "DriverDateOfBirth": driverDob.text.isEmpty ? "" : driverDob.text,
      "LicenseIssueDate":
          licenseIssueDate.text.isEmpty ? "" : licenseIssueDate.text,
      "FixingCarLocation": postDealershipValue,
      "SurveyDate": surveyDate.text.isEmpty ? "" : surveyDate.text,
      "ClaimType": claimType,
      "OtherPartyInvolved": otherPartInvolved[0]
          ? true
          : otherPartInvolved[1]
              ? true
              : false,
      "ThirdPartyName":
          insuranceCompanyName.isNotEmpty && insuranceCompanyName != 'SELECT'
              ? insuranceCompanyName
              : null,
      "ThirdPartyVehicleMake": vehicleMake.isNotEmpty && vehicleMake != 'SELECT'
          ? makeList
              .where((element) => element.description == vehicleMake)
              .first
              .code
          : null,
      "ThirdPartyVehicleYear":
          makeYear.value.isNotEmpty ? makeYear.value : null,
      "ThirdPartyPlateNumber":
          plateNumber.text.isNotEmpty ? plateNumber.text : null,
      "ThirdPartyPolicyNumber":
          policyNumber.text.isNotEmpty ? policyNumber.text : null,
      "ThirdPartyCprNumber":
          tpCprNumber.text.isNotEmpty ? tpCprNumber.text : null,
      "ThirdPartyFirstName":
          tpFirstName.text.isNotEmpty ? tpFirstName.text : null,
      "ThirdPartyMiddleName":
          tpMiddleName.text.isNotEmpty ? tpMiddleName.text : null,
      "ThirdPartyLastName": tpLastName.text.isNotEmpty ? tpLastName.text : null,
      "ThirdPartyDateOfBirth": tpDob.text.isNotEmpty ? tpDob.text : null,
      "ThirdPartyMobileNumber":
          tpMobileNumber.text.isNotEmpty ? tpMobileNumber.text : null,
      "ThirdPartyRegistrationNumber": tpRegistrationNumber.text.isNotEmpty
          ? tpRegistrationNumber.text
          : null,
      "ThirdPartyAddress": tpAddress.text.isNotEmpty ? tpAddress.text : null,
      "ThirdPartyContactNumber":
          tpContactNumber.text.isNotEmpty ? tpContactNumber.text : null,
    };

    res.Result result = await DioClient().post(
        'MotorClaim/SubmitMotorClaim', body,
        token: token,
        isPostData: true,
        showLongWaitingMessage: true,
        description: " ");
    if (result is res.SuccessState) {
      response = SubmitClaimResponse.fromJson(result.value);
      uploadDocument(_controller.uploadingDocumentPath, response.id, 0,
          response.claimNumber);
    } else if (result is res.ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera(String title) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      var temp = File(pickedFile.path);
      var renamedFile = await Utils.changeFileNameOnly(temp, title);
      List<String> filteredList = _controller.uploadingDocumentPath
          .where((e) => e.split('/').last.contains(title))
          .toList();
      if (filteredList.length > 0) {
        for (final e in filteredList) {
          final index = _controller.uploadingDocumentPath.indexOf(e);
          _controller.uploadingDocumentPath.removeAt(index);
          _controller.uploadingDocumentPath.insert(
              index, renamedFile.path); // Replacing inputString by 'newInput'
        }
      } else {
        _controller.uploadingDocumentPath.add(renamedFile.path); //
      }
    } else {
      print('No image selected.');
    }
    Get.back();
    _controller.update();
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery(String title) async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      var temp = File(result.files.single.path);
      var renamedFile = await Utils.changeFileNameOnly(temp, title);
      List<String> filteredList = _controller.uploadingDocumentPath
          .where((e) => e.split('/').last.contains(title))
          .toList();
      if (filteredList.length > 0) {
        for (final e in filteredList) {
          final index = _controller.uploadingDocumentPath.indexOf(e);
          _controller.uploadingDocumentPath.removeAt(index);
          _controller.uploadingDocumentPath.insert(
              index, renamedFile.path); // Replacing inputString by 'newInput'
        }
      } else {
        _controller.uploadingDocumentPath.add(renamedFile.path); //
      }
    } else {
      // User canceled the picker
    }
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   image = File(pickedFile.path);
    // } else {
    //   print('No image selected.');
    // }
    Get.back();
    _controller.update();
  }

  //upload document
  uploadDocument(
      List<String> imagePath, int id, int counter, String claimNumber) async {
    dio.FormData details = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        imagePath[counter],
      )
    });

    var type = imagePath[counter].split('/').last.contains('Ownership\n(front)')
        ? 'OwnershipFront'
        : imagePath[counter].split('/').last.contains('Ownership\n(back)')
            ? 'OwnershipBack'
            : imagePath[counter]
                    .split('/')
                    .last
                    .contains('Driving license\n(front)')
                ? 'DrivingLicenseFront'
                : imagePath[counter]
                        .split('/')
                        .last
                        .contains('Driving license\n(back)')
                    ? 'DrivingLicenseBack'
                    : imagePath[counter]
                            .split('/')
                            .last
                            .contains('CPR\n(front)')
                        ? 'CprFront'
                        : imagePath[counter]
                                .split('/')
                                .last
                                .contains('CPR\n(back)')
                            ? 'CprBack'
                            : imagePath[counter]
                                    .split('/')
                                    .last
                                    .contains('Police Report')
                                ? 'PoliceReport'
                                : imagePath[counter]
                                        .split('/')
                                        .last
                                        .contains('Copy of IBAN')
                                    ? 'Iban'
                                    : 'Other';
    res.Result result = await DioClient().post(
        'MotorClaim/UploadClaimAttachment?id=$id&type=$type', details,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is res.SuccessState) {
      counter += 1;
      if (counter == _controller.uploadingDocumentPath.length) {
        sendemailApi(id, "Motor claim with police report");
      } else {
        uploadDocument(
            _controller.uploadingDocumentPath, id, counter, claimNumber);
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void sendemailApi(int claimId, String claimType) async {
    res.Result result = await DioClient()
        .get('MotorClaim/SendClaimEmail?id=$claimId', token, isLoading: true);

    if (result is res.SuccessState) {
      Get.offNamed(AppRoutes.SUCCESS_CLAIM, arguments: {
        'claimId': '$claimId',
        'isFromMedical': false,
        'fromProductName': "Motor Claims",
        "claim_type": claimType
      });
    } else if (result is res.ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }

//if the file is uploaded based on this bvalue the preview on the screen is shown
  bool alreadyExist(String title) {
    List<String> filteredList = _controller.uploadingDocumentPath
        .where((e) => e.split('/').last.contains(title))
        .toList();
    return filteredList.length > 0 ? true : false;
  }

  // all Document Mandatory
  bool checkAllDocumentsSubmitted() {
    List<String> filteredList = _controller.uploadingDocumentPath
        .where((e) => e.split('/').last.contains('Other Documents'))
        .toList();
    if (filteredList.length == 0 &&
        _controller.uploadingDocumentPath.length < 5) {
      return false;
    } else if (filteredList.length >= 0 &&
        _controller.uploadingDocumentPath.length - 1 >= 8) {
      return true;
    } else if (filteredList.length >= 0 &&
        ((_controller.uploadingDocumentPath.length) == 6) &&
        (verification.personalVerification &&
            selectedDriverType != "Not Policy Holder"))
      return true;
    else if (filteredList.length > 0 &&
        _controller.uploadingDocumentPath.length <= 8) {
      return false;
    } else if (filteredList.length == 0 &&
        _controller.uploadingDocumentPath.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  void setCalimAgainst(String val) {
    selectedClainAgainst = val;
    driverType[0] = false;
    driverType[1] = false;
    otherPartInvolved[0] = false;
    otherPartInvolved[1] = false;
    update();
  }

  Future<void> getVehicleMakeList() async {
    res.Result result =
        await DioClient().get('Motor/GetVehicleMakeJson', token);
    if (result is res.SuccessState) {
      var jsonData = List<VehicleMake>.from(
          result.value.map((x) => VehicleMake.fromJson(x)));
      if (jsonData is List<VehicleMake>) {
        makeList = jsonData;
        vehicleMakeList.addAll(jsonData.map((e) => e.description).toList());
        getInsuranceCompanyList();
        update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  Future<void> getVehicleModle(String value) async {
    var requestData = {"makeCode": value};

    res.Result result = await DioClient().post(
        'Motor/GetVehicleModelList', requestData,
        token: token, isPostData: true);
    if (result is res.SuccessState) {
      var jsonData = VehicleModel.fromJson(result.value);
      if (jsonData is VehicleModel) {
        modelList = null;
        modelList = jsonData.vehicleModel[0].modelDetails;

        vehicleModelList.addAll(modelList.map((e) => e.model).toSet().toList());

        update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  Future<void> getMakeYear(String value) async {
    res.Result result = await DioClient()
        .get('Motor/GetVehicleYear?vehicleModel=$value', token);
    if (result is res.SuccessState) {
      var jsonData = MakeYear.fromJson(result.value);

      makeYearList = [makeYear.value];
      makeYearList.addAll(jsonData.years.map((e) => e.toString()).toList());
      update();
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void getUserIdentificationStatus() async {
    res.Result result = await DioClient()
        .get('Customer/PersonalVerification', token, isLoading: false);

    if (result is res.SuccessState) {
      //  var json = myTransformer.toGData();
      verification = PersonalVerification.fromJson(result.value);
    }
  }

  Future<void> getInsuranceCompanyList() async {
    res.Result result =
        await DioClient().get('Values/InsuranceCompanies', token);
    if (result is res.SuccessState) {
      var json = InsuranceCompanyList.fromJson(result.value);
      insuranceCompanyList.addAll(json.result);
      update();
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }
}
