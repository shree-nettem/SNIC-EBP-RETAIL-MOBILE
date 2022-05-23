import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/credentials.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:jumio_mobile_sdk_flutter/jumio_mobile_sdk_flutter.dart';

import '../../../../../../services/dio_client.dart';
import '../../../../../../services/result.dart';
import '../../../../../../utilities/app_helper.dart';
import '../../../../../../utilities/shared_preference.dart';
import '../../../login/login_model.dart';
import '../../../login/token_model.dart';

class IdentityVerificationRequiredXController extends GetxController {
  int userId, stepId;
  String referralCode = "";
  String email, password;

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments['id'];
      stepId = Get.arguments['step_id'];
      if (stepId == 3) {
        email = Get.arguments['email'];
        password = Get.arguments['password'];
      }
      referralCode = Get.arguments['referral_code'];
      debugPrint("REFERRAL_CODE $referralCode");
    }

    super.onInit();
  }

  void initializeJumio() {
    _startNetverify();
  }

  Future<void> _startNetverify() async {
    String callBackURL =
        "https://jumio.snic.com.bh/Onboarding/SetIdentityVerification?id=$userId&referralCode=$referralCode";
    await _logErrors(() async {
      await JumioMobileSDK.initNetverify(API_TOKEN, API_SECRET, DATACENTER, {
        "enableVerification": true,
        "callbackUrl": callBackURL,
        "enableIdentityVerification": true,
        "preselectedCountry": "BHR",
        "customerInternalReference": userId.toString(),
        "userReference": userId.toString(),
        "reportingCriteria": "Criteria",
        "sendDebugInfoToJumio": true,
        // "dataExtractionOnMobileOnly": false,
        "cameraPosition": "back",
        //"preselectedDocumentVariant": "plastic",
        "documentTypes": [
          // "PASSPORT",
          // "DRIVER_LICENSE",
          "IDENTITY_CARD"
          // "VISA"
        ],
        "enableWatchlistScreening": ["enabled"],
        "watchlistSearchProfile": "afbb950f-b540-407c-9a3e-9815816ca91b",
      });
      final result = await JumioMobileSDK.startNetverify();
      debugPrint("JUMIO_RESULT $result");

      if (Utils.getJumioErrorMessage(result['errorCode']).isEmpty) {
        //CHECK BOTH AGE AND EXPIRY CARD DATE
        String dob = result['dob'];
        String expiryDate = result['expiryDate'];
        validateJumioResponse(dob, expiryDate);
      } else {
        String message = Utils.getJumioErrorMessage(result['errorCode']);
        errorMessage(message);
      }
    });
  }

  // VALIDATE THE JUMIO RESPONSE
  validateJumioResponse(String dob, String expiryDate) {
    String dateOfBirth = Utils.formattedDate(dob.replaceAll(' ', ''));
    String cardExpiryDate = Utils.formattedDate(expiryDate.replaceAll(' ', ''));

    if (Utils.convertStringDateToDate(cardExpiryDate).isAfter(DateTime.now())) {
      if (Utils.isAdult(dateOfBirth)) {
        Get.toNamed(AppRoutes.IDENTITY_VERIFICATION_COMPLETED, arguments: {
          'id': userId,
          "step_id": 4,
        });
      } else {
        errorMessage("You are not 18 years old!");
      }
    } else {
      errorMessage(
          "Dear Customer, Unfortunately your CPR is expired. Kindly renew your CPR to continue with the process.");
    }
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

  // IF THE STEP ID IS 3 AND USER PRESSES SKIP BUTTON
  // CALL LOGIN API AGAIN AND LET USER TO HOME SCREEN
  loginUser() async {
    update();
    var loginMap = {
      "UserName": email,
      "Password": password,
      "AppID": "EBP_RETAIL",
    };

    debugPrint("LOGIN $loginMap");

    Result result = await DioClient().post('Authenticate', loginMap);
    if (result is SuccessState) {
      update();
      var jsonData = LoginModel.fromJson(result.value);
      if (jsonData is LoginModel) {
        int currentStepId = jsonData.onboarding.currentStepId;
        /* STEP ID 5 -> CUSTOMER VERIFIED COMPLETELY AND LOGIN */
        var companyId = jsonData.companies[0].companyID;
        var userId = jsonData.id;
        SharedPreferencesHelper().setUserId(userId);
        SharedPreferencesHelper().setEmail(email);
        SharedPreferencesHelper().setPassword(password);
        SharedPreferencesHelper().setCustomerId(jsonData.customerId.toString());
        SharedPreferencesHelper()
            .setReferralCode(jsonData.referralCode.toString());
        SharedPreferencesHelper()
            .setNumberOfReferrals(jsonData.numberOfReferrals);
        token(companyId);
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  token(int companyId) async {
    var requestMap = {
      "Username": email,
      "Password": password,
      "grant_type": "password",
      "AppID": "EBP_RETAIL",
      "CompanyID": companyId,
      "InsurerID": 2,
    };

    Result result = await DioClient().post('token', requestMap);
    if (result is SuccessState) {
      var jsonData = TokenModel.fromJson(result.value);
      if (jsonData is TokenModel) {
        jsonData.companyId = companyId.toString();
        saveUserDetails(jsonData);
        Get.offAndToNamed(AppRoutes.DASHBOARD);
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  // SAVING DETAILS IN SHARED PREFERENCES
  void saveUserDetails(TokenModel tokenModel) async {
    var userDetails = TokenModel(
        accessToken: tokenModel.accessToken,
        tokenType: tokenModel.tokenType,
        expiresIn: tokenModel.expiresIn,
        name: tokenModel.name,
        companies: tokenModel.companies,
        issued: tokenModel.issued,
        expires: tokenModel.expires,
        companyId: tokenModel.companyId);

    AppHelper.saveKeepMeSignedIn(true);
    SharedPreferencesHelper.saveUserDetails(userDetails);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
