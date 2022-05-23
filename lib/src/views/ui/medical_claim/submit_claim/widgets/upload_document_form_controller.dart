import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/submit_claim_screen_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../../medical_claim_screen_controller.dart';

class UploadDocumentFormXController extends GetxController {
  String token;
  final picker = ImagePicker();

  File reimbbursementFrom;
  File receipts;
  File newDoc;

  @override
  void onInit() {
    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  //upload document
  uploadDocumet(String imagePath, String requestId, int type) async {
    dio.FormData details = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        imagePath,
      )
    });
    Result result = await DioClient().post(
        'Medical/UploadDocument?requestID=$requestId&type=$type', details,
        token: token, isPostData: true, isHeaderJsonType: true);

    if (result is SuccessState) {
    } else if (result is ErrorState) {}
  }

  //upload document
  submitClaim() async {
    var requestId = Get.find<SubmitClaimScreenXController>().savedRequestId;
    Result result = await DioClient()
        .get('Medical/SubmitClaim?RequestID=$requestId', token);

    if (result is SuccessState) {
      Get.find<SubmitClaimScreenXController>().filedUploaded = true;
      debugPrint("SUCCESS_CLAIM 62");
      Get.toNamed(AppRoutes.SUCCESS_CLAIM, arguments: {
        'claimId': result.value["referenceId"].toString(),
        'isFromMedical': true,
        'fromProductName': "Medical Claims"
      });
    } else if (result is ErrorState) {
      errorMessage('errorOccured'.tr);
    }
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera(int type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (type == 5) {
        reimbbursementFrom = File(pickedFile.path);
      } else if (type == 8) {
        receipts = File(pickedFile.path);
      } else {
        newDoc = File(pickedFile.path);
      }
      var requestId = Get.find<SubmitClaimScreenXController>().savedRequestId;
      uploadDocumet(pickedFile.path, requestId, type);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery(int type) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);

    if (result != null) {
      if (type == 5) {
        reimbbursementFrom = File(result.files.single.path);
      } else if (type == 8) {
        receipts = File(result.files.single.path);
      } else {
        newDoc = File(result.files.single.path);
      }

      var requestId = Get.find<SubmitClaimScreenXController>().savedRequestId;
      uploadDocumet(result.files.single.path, requestId, type);
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
    update();
  }
}
