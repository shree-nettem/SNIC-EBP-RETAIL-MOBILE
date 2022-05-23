import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/credentials.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:jumio_mobile_sdk_flutter/jumio_mobile_sdk_flutter.dart';

class PersonalIdentificationRequiredXController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int userId, stepId;

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments['id'];
      stepId = Get.arguments['step_id'];
    }

    super.onInit();
  }

  void initializeJumio() {
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
        "reportingCriteria": "NewCustomerOnboarding",
        "customerInternalReference": userId.toString(),
        "userReference": userId.toString(),
        "sendDebugInfoToJumio": true,
        "cameraPosition": "back",
        "documentTypes": ["IDENTITY_CARD"],
        "enableWatchlistScreening": ["enabled"],
        "watchlistSearchProfile": "afbb950f-b540-407c-9a3e-9815816ca91b",
      });
      final result = await JumioMobileSDK.startNetverify();
      if (Utils.getJumioErrorMessage(result['errorCode']).isEmpty) {
        Get.toNamed(AppRoutes.PERSONAL_IDENTIFICATION_COMPLETED, arguments: {
          'id': userId,
          "step_id": 4,
        });
      } else {
        String message = Utils.getJumioErrorMessage(result['errorCode']);
        errorMessage(message);
      }

      debugPrint("JUMIO RESULT $result");
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

  // void getVerificationResponse() async {
  //   isAnalyzed = true;
  //   update();
  //   if (Utils.isInternetConnected() != null) {
  //     Result result = await DioClient().get(
  //         'Onboarding/GetVerificationResponse?id=$userId', "",
  //         isLoading: false);
  //     if (result is SuccessState) {
  //       analyse(false);
  //
  //       var jsonData = VerificationResponseModel.fromJson(result.value);
  //       if (jsonData is VerificationResponseModel) {
  //         /* HIT SET IDENTITY VERIFICATION API */
  //         final body = json.decode(jsonData.benefitResponse);
  //
  //         final messageStatus = body["messageStatus"];
  //         debugPrint("MESSAGE_STATUS $messageStatus");
  //         if (body != null && messageStatus == "OK") {
  //           Get.toNamed(AppRoutes.COMPLETE_PROFILE, arguments: [
  //             {
  //               "body": body,
  //               "user_id": userId,
  //               "existing_customer": jsonData.existingCustomer
  //             }
  //           ]);
  //         } else {
  //           errorMessage("Benefit Response is null or error!");
  //         }
  //       }
  //     } else if (result is ErrorState) {
  //       analyse(false);
  //       errorMessage(result.msg.toString());
  //     }
  //   } else {
  //     analyse(false);
  //     errorMessage("Please connect to the network");
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }
}
