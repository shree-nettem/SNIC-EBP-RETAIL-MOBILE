import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/credentials.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jumio_mobile_sdk_flutter/jumio_mobile_sdk_flutter.dart';
import 'package:scan/scan.dart';

import '../verification_model.dart';

class EmailVerificationXController extends GetxController {
  TextEditingController emailController;
  TextEditingController referralCodeController;
  int userId, stepId;
  String referralCode = "";
  bool isEmail = true;
  bool isConfirmEmail = false;
  bool isEmailVerified = false;

  //SLIDER VARIABLES
  bool isEmailViewVisible = false;
  TextEditingController otpController;
  ScanResult scanResult;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      userId = Get.arguments['id'];
      stepId = Get.arguments['step_id'];
      debugPrint("USER ID $userId ");
      /* IF STEP ID IS 2, THEN THE VERIFICATION HAS BEEN COMPLETED 
      AND REDIRECT USER TO EMAIL VERIFIED SCREEN
      WITH REFERRAL CODE OPTION */
      if (stepId == 2) {
        isEmail = false;
        isConfirmEmail = false;
        isEmailVerified = true;
        update();
      }
    }

    emailController = TextEditingController();
    otpController = TextEditingController();
    referralCodeController = TextEditingController();
  }

  // BACK TO MODIFY PHONE NUMBER SCREEN
  void modifyPhoneNumber() {
    isEmail = true;
    isConfirmEmail = false;
    isEmailVerified = false;
    update();
  }

  //EMAIL VERIFICATION
  void verifyEMAIL() {
    if (Utils.isInternetConnected() != null) {
      String email = emailController.text;
      var data = {"Email": email.trim()};
      requestEmailOTP(data);
    } else {
      errorMessage("Please connect to the network");
    }
  }

  Future<void> requestEmailOTP(data) async {
    Result result =
        await DioClient().post('Onboarding/SetEmail?id=$userId', data);
    if (result is SuccessState) {
      var jsonData = VerificationModel.fromJson(result.value);
      if (jsonData is VerificationModel) {
        /* MOBILE VERIFIED == 1 */
        if (jsonData.currentStepId == 1) {
          debugPrint("MOBILE VERIFIED AND REQUEST SENT FOR EMAIL");
          isEmail = false;
          isConfirmEmail = true;
          isEmailVerified = false;
          update();
        } else {
          Get.toNamed(AppRoutes.VERIFY_MOBILE_NUMBER,
              arguments: {'id': jsonData.iD, "step_id": 2});
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  //VERIFY THE ACCOUNT USING OTP EMAIL
  void enableEmail(type) {
    if (Utils.isInternetConnected() != null) {
      verifyOTP(type);
    } else {
      errorMessage("Please connect to the network");
    }
  }

  Future<void> verifyOTP(type) async {
    String code = otpController.text;
    String apiEndPointWithParams =
        'Onboarding/VerifyOTP?id=$userId&type=$type&otp=$code';

    debugPrint("VERIFY OTP $apiEndPointWithParams");
    Result result = await DioClient().get(apiEndPointWithParams, "");
    if (result is SuccessState) {
      var jsonData = VerificationModel.fromJson(result.value);
      if (jsonData is VerificationModel) {
        if (jsonData.currentStepId == 1) {
          successMessage("Phone number successfully verified");
          Future.delayed(const Duration(seconds: 1), () {
            Get.toNamed(AppRoutes.CONFIRM_EMAIL, arguments: {
              'id': jsonData.iD,
              "step_id": 1,
            });
          });
          otpController.clear();
        } else if (jsonData.currentStepId == 2) {
          successMessage("Email successfully verified");
          isEmail = false;
          isConfirmEmail = false;
          isEmailVerified = true;
          update();
        }
      } else {
        errorMessage("Could not verify phone number");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  //WHEN USER PRESSES RESENT OTP TEXT FOR EMAIL
  void resendOTP(String type) async {
    String apiEndPointWithParams = 'Onboarding/ResendOTP?id=$userId&type=$type';

    debugPrint("RESEND OTP $apiEndPointWithParams");
    Result result =
        await DioClient().post(apiEndPointWithParams, "", isPostData: false);
    if (result is SuccessState) {
      var jsonData = VerificationModel.fromJson(result.value);
      if (jsonData is VerificationModel) {
        int stepId = jsonData.currentStepId;
        successMessage("OTP resent successfully");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

/* CAPTURE THE CPR USING JUMIO */
  void JUMIOCPRVerify() {
    _startNetverify();
  }

  Future<void> _startNetverify() async {
    String callBackURL =
        "https://jumio.snic.com.bh/Onboarding/SetIdentityVerification?id=$userId&referralCode=";
    await _logErrors(() async {
      await JumioMobileSDK.initNetverify(API_TOKEN, API_SECRET, DATACENTER, {
        "enableVerification": true,
        "callbackUrl": callBackURL,
        "enableIdentityVerification": true,
        "preselectedCountry": "BHR",
        "reportingCriteria": "Criteria",
        "sendDebugInfoToJumio": true,
        "customerInternalReference": userId.toString(),
        "userReference": userId.toString(),
        // "dataExtractionOnMobileOnly": false,
        "cameraPosition": "back",
        //"preselectedDocumentVariant": "plastic",
        "documentTypes": [
          // "PASSPORT",
          // "DRIVER_LICENSE",
          "IDENTITY_CARD"
          // "VISA"
        ],
        // "enableWatchlistScreening": ["enabled", "disabled" || "default"],
        //"watchlistSearchProfile": "YOURPROFILENAME",
      });
      final result = await JumioMobileSDK.startNetverify();
      debugPrint("JUMIO RESULT $result");
      await _showDialogWithMessage("Netverify has completed. Result: $result");
    });
  }

  Future<void> _logErrors(Future<void> Function() block) async {
    try {
      await block();
    } catch (error) {
      await _showDialogWithMessage(error.toString(), "Error");
    }
  }

  Future<void> _showDialogWithMessage(String message,
      [String title = "Result"]) async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: Text(message)),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ON QR CODE TAPPED, DISPLAY THE BOTTOM DRAWER ALONG WITH THE TWO OPTION
  scanQRCode() async {
    var _aspectTolerance = 0.00;
    var _selectedCamera = -1;
    var _useAutoFocus = true;
    var _autoEnableFlash = false;
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': "cancel",
            'flash_on': "flash on",
            'flash_off': "flash off",
          },
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      scanResult = result;
      debugPrint("SCAN_RESULT ${scanResult.type}");
      if (scanResult.type.toString() == "Barcode") {
        referralCodeController.text = scanResult.rawContent;
        Get.back();
      }
      update();
    } on PlatformException catch (e) {
      scanResult = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
        rawContent: e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e',
      );
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    referralCodeController.dispose();
  }

  void getImageGallery() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);
    final pickedFile = File(result.files.single.path);
    if (pickedFile != null) {
      File imagePath = File(pickedFile.path);
      String result = await Scan.parse(imagePath.path);
      print('Image selected from Gallery.${imagePath.path} {$result}}');
      if (result != null) {
        referralCodeController.text = result;
      }
      Get.back();
    } else {
      print('No image selected.');
    }
    update();
  }

  void verifyReferralCode() {
    if (Utils.isInternetConnected() != null) {
      return verifyCode();
    } else {
      errorMessage("Please connect to the network");
    }
  }

  verifyCode() async {
    Result result = await DioClient().get(
        "Onboarding/VerifyReferralCode?code=${referralCodeController.text}",
        "");
    if (result is SuccessState) {
      debugPrint("Success");
      Get.toNamed(
        AppRoutes.IDENTITY_VERIFICATION_REQUIRED,
        arguments: {"referral_code": referralCodeController.text, "id": userId},
      );
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }
}
