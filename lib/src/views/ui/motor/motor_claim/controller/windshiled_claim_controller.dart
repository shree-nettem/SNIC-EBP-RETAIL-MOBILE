import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/garage_list.dart';
import 'package:ebpv2/src/views/ui/motor/model/submit_claim_response.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:ebpv2/src/services/result.dart' as res;
import 'package:image_picker/image_picker.dart';

import 'motor_claim_controller.dart';

class WindScreenClaimFlowXController extends GetxController {
  final formKey = GlobalKey<FormState>();
  List<String> dealership;
  final picker = ImagePicker();
/*  TextEditingController
      driverName,
      driverDob,
      licenseIssueDate,description,;*/

  TextEditingController surveyDate, description;
  List<bool> otherPartInvolved, driverType;
  String token, selectedDealership;
/*  String selectedDriverType;*/
  bool isOtherPartyInvolved;

  SelectVehicleXController controller = Get.find();
  MotorClaimXController _controller = Get.find();
  GarageList garageList;
  SubmitClaimResponse response;

  @override
  void onInit() {
    isOtherPartyInvolved = false;
    /* description=TextEditingController();
    driverDob=TextEditingController();
    driverName=TextEditingController();
    licenseIssueDate=TextEditingController();*/
    surveyDate = TextEditingController();
    otherPartInvolved = [false, false];
    description = TextEditingController();
    // driverType=[false,false];
    dealership = ["Select"];
    selectedDealership = dealership[0];

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getToken();
  }

  @override
  void onClose() {
    /*  driverName.dispose();
    licenseIssueDate.dispose();
    driverDob.dispose();
    description.dispose();*/
    surveyDate.dispose();
    description.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    // getGarageDealerShip();
  }

  //choose from party involved
  switchPartyInvolved(index, MotorClaimXController claimController) {
    for (int i = 0; i < otherPartInvolved.length; i++) {
      otherPartInvolved[i] = i == index;
    }
    if (otherPartInvolved[0]) {
      isOtherPartyInvolved = true;
    } else if (otherPartInvolved[1]) {
      isOtherPartyInvolved = false;
    }
    claimController.update();
  }

  /* switchDrivertype(index, MotorClaimXController claimController){
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
*/
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
      "PoliceReportDate": null,
      "PoliceReportNumber": null,
      "LossDescription": description.text,
      "Responsibility": null,
      "AccidentType": "Accident",
      "AccidentLocationCountry": null,
      "AccidentLocation": null,
      "DriverType": null,
      "DriverName": null,
      "DriverDateOfBirth": null,
      "LicenseIssueDate": null,
      "FixingCarLocation": postDealershipValue,
      "SurveyDate": surveyDate.text,
      "ClaimType": "Car Windscreen claim",
      "IntimationNumber": null,
      "OtherPartyInvolved": isOtherPartyInvolved,
    };

    res.Result result = await DioClient().post(
        'MotorClaim/SubmitMotorClaim', body,
        token: token, isPostData: true, showLongWaitingMessage: true);
    if (result is res.SuccessState) {
      response = SubmitClaimResponse.fromJson(result.value);

      uploadDocument(_controller.uploadingDocumentPath, response.id, 0,
          response.claimNumber);
    } else if (result is res.ErrorState) {
      // Get.back();
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

  //get garageDealerShip lookUp list
  void getGarageDealerShip(String policyNumber) async {
    res.Result result = await DioClient()
        .get('Motor/GetGarageList?policyNumber=$policyNumber', token);
    if (result is res.SuccessState) {
      garageList = GarageList.fromJson(result.value);
      dealership.clear();
      dealership = ["Select"];
      dealership.addAll(garageList.result.map((e) => e.label).toList());
      if (dealership.contains("Dealership")) {
        selectedDealership = "Dealership";
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //upload document
  uploadDocument(
      List<String> imagePath, int id, int counter, String claimNumber) async {
    dio.FormData details = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        imagePath[counter],
      )
    });
    var type = imagePath[counter].split('/').last.contains('Windscreen Picture')
        ? 'WindscreenPicture'
        : imagePath[counter].split('/').last.contains('Car Picture')
            ? 'CarPicture'
            : 'Other';
    res.Result result = await DioClient().post(
        'MotorClaim/UploadClaimAttachment?id=$id&type=$type', details,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is res.SuccessState) {
      counter += 1;
      if (counter == _controller.uploadingDocumentPath.length) {
        sendemailApi(id, "Car Windscreen claim");
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

  // all Document Mandatory
  bool checkAllDocumentsSubmitted() {
    if (_controller.uploadingDocumentPath.length < 2) {
      return false;
    } else if (_controller.uploadingDocumentPath.length >= 2) {
      return true;
    } else {
      return false;
    }
  }

  //if the file is uploaded based on this bvalue the preview on the screen is shown
  bool alreadyExist(String title) {
    List<String> filteredList = _controller.uploadingDocumentPath
        .where((e) => e.split('/').last.contains(title))
        .toList();
    return filteredList.length > 0 ? true : false;
  }
}
