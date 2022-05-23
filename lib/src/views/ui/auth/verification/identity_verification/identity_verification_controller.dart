import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

import '../verification_response_model.dart';

class IdentityVerificationXController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController animationController;
  bool isIdentityVerifyCPR = true;
  bool isIdentityFacial = false;
  bool isAnalyzed = false;
  File image;
  final picker = ImagePicker();
  int count = 0;
  int targetCount = 5;
  int userId, stepId;
  bool showAnimation = true;

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments['id'];
      stepId = Get.arguments['step_id'];
    }
    super.onInit();
  }

  analyse(bool isAnalyzing) async {
    animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          showAnimation = isAnalyzing;
          update();
        }
      });
  }

  /* HIT SET IDENTITY VERIFICATION API */
  Future getVerificationResponse() async {
    isAnalyzed = true;
    update();
    if (Utils.isInternetConnected() != null) {
      Result result = await DioClient().get(
          'Onboarding/GetVerificationResponse?id=$userId', "",
          isLoading: false);
      if (result is SuccessState) {
        var jsonData = VerificationResponseModel.fromJson(result.value);
        if (jsonData.benefitResponse != null &&
            jsonData.jumioResponse != null) {
          final body = json.decode(jsonData.jumioResponse);
          String jumioVerificationStatus = body['verificationStatus'];

          if (jumioVerificationStatus == "APPROVED_VERIFIED") {
            if (jsonData is VerificationResponseModel &&
                jsonData.benefitResponse != null) {
              isAnalyzed = false;

              final body = json.decode(jsonData.benefitResponse);

              final messageStatus = body["messageStatus"];
              var amlResponse;
              if (body != null && messageStatus == "OK") {
                var jumioAMLResponse;
                if (jsonData.jumioAMLResponse != null) {
                  jumioAMLResponse = json.decode(jsonData.jumioAMLResponse);
                  debugPrint(
                      "MESSAGE_STATUS ${jumioAMLResponse["document"]["status"]}");
                  amlResponse = jumioAMLResponse["document"]["status"];
                }
                if (amlResponse == "APPROVED_VERIFIED") {
                  Get.toNamed(AppRoutes.COMPLETE_PROFILE, arguments: [
                    {
                      "body": body,
                      "user_id": userId,
                      "existing_customer": jsonData.existingCustomer
                    }
                  ]);
                } else {
                  isAnalyzed = false;
                  errorMessage("Kindly contact the Administrator");
                  update();
                }
              } else {
                isAnalyzed = false;
                update();
                errorMessage("No records found from Benefits");
              }
            } else {
              // CALL SAME API, IF IT IS NULL
            }
          } else {
            isAnalyzed = false;
            update();
            errorMessage("Identity verification has failed. Kindly try again");
          }
        } else {
          await Future.delayed(Duration(seconds: 5));
          getVerificationResponse();
        }
      } else if (result is ErrorState) {
        isAnalyzed = false;
        update();
        errorMessage(result.msg.toString());
      }
    } else {
      isAnalyzed = false;
      update();
      errorMessage("Please connect to the network");
    }
  }

  @override
  void onClose() {
    super.onClose();
    animationController.dispose();
  }
}
