import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/medical_claims_list_model.dart';
import 'package:ebpv2/src/views/ui/motor/model/claim_download_document.dart';
import 'package:ebpv2/src/views/ui/motor/model/minor_claim.dart';
import 'package:ebpv2/src/views/ui/motor/model/police_report_claim.dart';
import 'package:ebpv2/src/views/ui/motor/model/windscreen_claim.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyClaimDetailXController extends GetxController {
  String token;
  String requestID, flow, claimType;
  MedicalClaimsListModel medicalClaims;

  MinorClaim minorClaim;
  WindScreenClaim windScreenClaim;
  PoliceReportClaim policeReportClaim;

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    if (flow == 'Medical') {
      getMedicalClaimDetail();
    } else if (flow == 'Motor') {
      getMotorClaimDetails();
    }
  }

  @override
  void onInit() {
    getToken();
    if (Get.arguments != null) {
      requestID = Get.arguments['requestID'].toString();
      flow = Get.arguments['flow'].toString();
      claimType = Get.arguments['claimType'].toString();
    }
    /* if(Get.arguments!=null){
      if(Get.arguments['isMotorDetails']){
        getClaimDetails(token,requestID);
      }
    }*/

    super.onInit();
  }

  getMedicalClaimDetail() async {
    // Utils.showProgressDialog(Get.context, '', 'Loading...');

    Result result =
        await DioClient().get('Medical/GetClaim?RequestID=$requestID', token);
    // Get.back();
    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }

      var jsonData = MedicalClaimsListModel.fromJson(result.value);

      medicalClaims = jsonData;

      update();
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.error.toString());
    }
  }

  String getStatusOfClaim(int statusId) {
    switch (statusId) {
      case 0:
        return "draft".tr;
        break;
      case 1:
        return "submitted".tr;
        break;
      case 2:
        return "processing".tr;
        break;
      case 3:
        return "approved".tr;
        break;
      case 4:
        return "rejected".tr;
        break;
      default:
        return "draft".tr;
    }
  }

  Color getStatusColor(int statusId) {
    switch (statusId) {
      case 0:
        return MyColors.GrayColor;
        break;
      case 1:
        return MyColors.themeColor;
        break;
      case 2:
        return MyColors.themeColor;
        break;
      case 3:
        return MyColors.greeen;
        break;
      case 4:
        return MyColors.red;
        break;
      default:
        return MyColors.GrayColor;
    }
  }

  void getMotorClaimDetails() async {
    Result result = await DioClient()
        .get('MotorClaim/GetClaimDetails?id=$requestID', token);
    // Get.back();
    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }
      if (claimType == 'Car Windscreen claim') {
        windScreenClaim = WindScreenClaim.fromJson(result.value);
      } else if (claimType == 'Motor claim with police report') {
        policeReportClaim = PoliceReportClaim.fromJson(result.value);
      } else if (claimType == 'Minor Motor Claims') {
        minorClaim = MinorClaim.fromJson(result.value);
      }
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  void downloadImage(int id, String type, bool isViewSelected) async {
    Result result = await DioClient().get(
      'MotorClaim/DownloadClaimAttachmentBase64?id=$id&type=$type',
      token,
    );
    if (result is SuccessState) {
      ClaimDownloadDocument res = ClaimDownloadDocument.fromJson(result.value);
      if (isViewSelected) {
        Utils.saveFileFromString(res.content, isViewSelected, claimType);
      } else if (!isViewSelected) {
        Utils.saveFileFromString(res.content, isViewSelected, claimType);
        CustomDialogHelper.showAlertDialog(
            title: "Alert",
            description: 'documentDownloaded'.tr,
            okBtnFunction: () {
              Get.back();
            });
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  void downloadAllDocuments(int id, List<ClaimAttachment> items, int i) async {
    if (items.length > i) {
      Result result = await DioClient().get(
        'MotorClaim/DownloadClaimAttachmentBase64?id=$id&type=${items[i].value}',
        token,
      );
      if (result is SuccessState) {
        ClaimDownloadDocument res =
            ClaimDownloadDocument.fromJson(result.value);
        Utils.saveALLRecords(res.content, i, claimType);

        if (items.length - 1 == i) {
          CustomDialogHelper.showAlertDialog(
              title: "Alert",
              description: 'allDocumentDownloaded'.tr,
              okBtnFunction: () {
                Get.back();
              });
        }
        downloadAllDocuments(id, items, i + 1);
      } else if (result is ErrorState) {
        errorMessage(result.msg);
      }
    }
  }
}
