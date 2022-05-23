import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/submit_claim_response.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:image_picker/image_picker.dart';

import '../../../../../services/result.dart';

class MinorMotorCalimXController extends GetxController {
  List<bool> eTrafficApplication;
  TextEditingController intimationNumber;
  SelectVehicleXController controller = Get.find();
  MotorClaimXController _controller = Get.find();
  String token;
  final picker = ImagePicker();

  SubmitClaimResponse response;

  @override
  void onInit() {
    intimationNumber = TextEditingController();
    eTrafficApplication = [false, false];
    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  //choose from cash and loan
  switchETrafficApplication(index, MotorClaimXController claimController) {
    for (int i = 0; i < eTrafficApplication.length; i++) {
      eTrafficApplication[i] = i == index;
    }
    claimController.update();
  }

  @override
  void onClose() {
    intimationNumber.dispose();
    super.onClose();
  }

  //submit claim for police report
  void submitClaim() async {
    var body = {
      "PolicyNumber": controller.selectedPolicy.policyNumber,
      "DateOfLoss": controller.selectedAccidentDate,
      "PoliceReportDate": null,
      "PoliceReportNumber": null,
      "LossDescription": null,
      "Responsibility": null,
      "AccidentType": "Accident",
      "AccidentLocationCountry": null,
      "AccidentLocation": null,
      "DriverType": null,
      "DriverName": null,
      "DriverDateOfBirth": null,
      "LicenseIssueDate": null,
      "FixingCarLocation": null,
      "SurveyDate": null,
      "ClaimType": "Minor Motor Claims",
      "IntimationNumber":
          intimationNumber.text.isEmpty ? "" : intimationNumber.text,
      "OtherPartyInvolved": null,
    };

    res.Result result = await DioClient().post(
        'MotorClaim/SubmitMotorClaim', body,
        token: token, isPostData: true, showLongWaitingMessage: true);
    if (result is res.SuccessState) {
      response = SubmitClaimResponse.fromJson(result.value);

      uploadDocument(_controller.uploadingDocumentPath, response.id, 0,
          response.claimNumber, response.claimType);
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
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);
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
  uploadDocument(List<String> imagePath, int id, int counter,
      String claimNumber, String claimType) async {
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
                    : 'Other';

    res.Result result = await DioClient().post(
        'MotorClaim/UploadClaimAttachment?id=$id&type=$type', details,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is res.SuccessState) {
      counter += 1;
      if (counter == _controller.uploadingDocumentPath.length) {
        sendemailApi(id, claimType);
      } else {
        uploadDocument(_controller.uploadingDocumentPath, id, counter,
            claimNumber, claimType);
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void sendemailApi(int claimId, String claimType) async {
    Result result = await DioClient()
        .get('MotorClaim/SendClaimEmail?id=$claimId', token, isLoading: true);

    if (result is SuccessState) {
      Get.offNamed(AppRoutes.SUCCESS_CLAIM, arguments: {
        'claimId': '$claimId',
        'isFromMedical': false,
        'fromProductName': "Motor Claims",
        'claim_type': claimType,
      });
    } else if (result is ErrorState) {
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
    if (_controller.uploadingDocumentPath.length < 4) {
      return false;
    } else if (_controller.uploadingDocumentPath.length >= 4) {
      return true;
    } else {
      return false;
    }
  }
}
