import 'dart:io';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

import 'motor_controller.dart';

class UploadDocumentController extends GetxController {
  String token;
  final picker = ImagePicker();

  final MotorXController motorXController = Get.find();
  final MotorPalnXController motorPalnXController = Get.find();

  File dealQuot;
  RxBool isDealerQuotionUploaded = false.obs;
  bool isCprValid;

  @override
  void onInit() {
    isDealerQuotionUploaded.value = false;
    isCprValid = false;
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
  uploadDocumet(String imagePath, int decider) async {
    final VehicleDetailsXController vehicleDetailsXController = Get.find();

    var documentType = '';
    dio.FormData details = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        imagePath,
      )
    });
    if (decider == 1) {
      documentType = 'DEALER QUOTATION';
    }
    var quoteIssued = motorPalnXController.quotationNumer;
    Result result = await DioClient().post(
        'Motor/UploadDocuments?proposalNumber='
        '${quoteIssued}'
        '&documentType=$documentType',
        details,
        token: token,
        isPostData: true,
        isHeaderJsonType: true);
    if (result is SuccessState) {
      if (decider == 1) {
        isDealerQuotionUploaded.value = true;
        motorPalnXController.postDraft(callCalculatePremium: true);
      }
      motorXController.update();
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  //upload document
  submitClaim() async {
    /*  var requestId = Get.find<SubmitClaimScreenXController>().savedRequestId;
    Result result = await DioClient()
        .get('Medical/SubmitClaim?RequestID=$requestId', token);

    if (result is SuccessState) {
      Get.find<SubmitClaimScreenXController>().filedUploaded = true;
      Get.toNamed(AppRoutes.SUCCESS_CLAIM,
          arguments: {'claimId': requestId, 'isFromMedical': true});
    } else if (result is ErrorState) {
      errorMessage(MyString.errorOccured);
    }*/
  }

  //GET IMAGE FROM THE CAMERA
  Future getImageCamera(int decider) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      dealQuot = File(pickedFile.path);
      uploadDocumet(dealQuot.path, decider);
    } else {
      print('No image selected.');
    }
    Get.back();
    update();
  }

  //GET IMAGE FROM THE GALLERY
  Future getImageGallery(int decider) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);

    if (result != null) {
      dealQuot = File(result.files.single.path);

      // var requestId = Get.find<SubmitClaimScreenXController>().savedRequestId;
      uploadDocumet(result.files.single.path, decider);
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
