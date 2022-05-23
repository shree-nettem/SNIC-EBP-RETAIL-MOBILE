import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/download_document.dart';
import 'package:ebpv2/src/views/ui/motor/model/issue_quote.dart';
import 'package:ebpv2/src/views/ui/motor/model/payment_ssue_policy_model.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/upload_document_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/image_view.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/payment_sucess_screen.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_fail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'motor_paln_Controller.dart';

class InsurancePaymentXController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String token;

  @override
  void onInit() {
    // TODO: implement onInit
    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print(token);
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  void confirmPayment(
      {int id,
      String token,
      IssueQuote quote,
      paymentMode = "BENEFITPAY"}) async {
    MotorPalnXController controller = Get.find();
    VehicleDetailsXController detailsXController = Get.find();
    MotorXController motorXController = Get.find();
    UploadDocumentController documentController = Get.find();
    PaymentXController paymentXController = Get.find();
    var payment = {
      "proposalNumber": quote.proposalNumber,
      "collectionMode": paymentMode, //CREDIMAX, ONLINEPAY, BENEFITPAY
      "transactionNumber": id != null ? id : "",
      "collectionAmount": paymentXController.discountAmount != null &&
              paymentXController.discountAmount.value.isNotEmpty &&
              double.parse(paymentXController.discountAmount.value) > 0
          ? (quote.policyPremium -
              double.parse(paymentXController.discountAmount.value))
          : quote.policyPremium
    };
    var discount = {
      "proposalNumber": quote.proposalNumber,
      "collectionMode": "LOLYTPT", //CREDIMAX, ONLINEPAY, BENEFITPAY
      "transactionNumber": id != null ? id : "",
      "collectionAmount": paymentXController.discountAmount.value,
    };
    var details;
    if (paymentXController.discountAmount != null &&
        paymentXController.discountAmount.value.isNotEmpty) {
      if (double.parse(paymentXController.discountAmount.value) > 0) {
        details = {
          "colPaymentList": [payment, discount]
        };
      } else {
        details = {
          "colPaymentList": [payment]
        };
      }
    } else {
      details = {
        "colPaymentList": [payment]
      };
    }

    Result result = await DioClient().post(
        'Motor/PaymentAndIssuePolicy', details,
        isPostData: true, token: token, isHeaderJsonType: true);
    if (result is SuccessState) {
      PaymentAndIssuePolicyModel response =
          PaymentAndIssuePolicyModel.fromJson(result.value);
      if (response.receiptNumber.isNotEmpty) {
        motorXController.draftProgressStatus[0].status = 1;
        motorXController.draftProgressStatus[1].status = 0;
        motorXController.draftProgressStatus[2].status = 0;
        controller.selectedIndex.value = 0;
        controller.isCashFlowVisible = false;
        controller.isQuotIssued = false;
        controller.isPlanSelected = false;
        controller.isLoanFlowVisible = false;
        controller.isCustomerFlowVisible = false;
        controller.isBankFlowVisible = false;
        documentController.isDealerQuotionUploaded.value = false;
        controller.quotationNumer = "";
        controller.eligibleOption.value = "SELECT";
        controller.selectedBankName.value = "SELECT";
        controller.paymentType = [false, false];
        motorXController.expansionCardKey[1].currentState.collapse();
        motorXController.expansionCardKey[2].currentState.collapse();
        DateTime startDate;
        if (detailsXController.policyStartDate.text.isNotEmpty) {
          startDate = DateFormat("yyyy-MM-dd")
              .parse(detailsXController.policyStartDate.text);
        } else {
          startDate = DateTime.now();
        }
        DateTime lastDayOfMonth =
            new DateTime(startDate.year + 1, startDate.month + 1, 0);
        detailsXController.policyExpiryDate.text =
            detailsXController.draftFormat.result.policyExpiryDate != null &&
                    detailsXController
                        .draftFormat.result.policyExpiryDate.isNotEmpty
                ? detailsXController.draftFormat.result.policyExpiryDate
                : Utils.convertDateTimeDisplay(lastDayOfMonth.toString());
        controller.postDraft(callCalculatePremium: true, issuedPolicy: true);
        Get.off(PaymentSuccessScreen(response));
      } else {
        Get.off(PaymentFailedScreen());
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

/*  //calculate total premium
  double calculateTotalPremeium(IssueQuote issedQuote) {

    //policy fees need to be added
    return double.parse((issedQuote.supplementaryBenefitsAmount +
        issedQuote.vatAmount +
        issedQuote.policyPremium).toStringAsFixed(3));

  }*/

  void downloadImage(PaymentAndIssuePolicyModel response, int index,
      bool isViewSelected) async {
    var details = {
      "level": "POLICY",
      "policyNumber": response.strPolicyQuoteNumber,
      "documentFileName": response.documentDetails[index].documentName,
      "documentType": response.documentDetails[index].documentType
    };

    Result result = await DioClient().post('Motor/DownloadDocument', details,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is SuccessState) {
      DownloadDocumentModel res = DownloadDocumentModel.fromJson(result.value);
      if (isViewSelected &&
          response.documentDetails[index].documentName.contains(".jpg")) {
        Image img = imageFromBase64String(res.buffer);
        Get.to(ImagePreview(img));
      } else if (isViewSelected) {
        Utils.saveFileFromString(res.buffer, isViewSelected,
            response.documentDetails[index].documentName);
      } else if (!isViewSelected) {
        Utils.saveFileFromString(res.buffer, isViewSelected,
            response.documentDetails[index].documentName);
        CustomDialogHelper.showAlertDialog(
            title: "Alert",
            description: "Document downloaded successfully",
            okBtnFunction: () {
              Get.back();
            });
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  void downloadAllDocuments(PaymentAndIssuePolicyModel response, int i) async {
    if (response.documentDetails.length > i) {
      var details = {
        "level": "POLICY",
        "policyNumber": response.strPolicyQuoteNumber,
        "documentFileName": response.documentDetails[i].documentName,
        "documentType": response.documentDetails[i].documentType
      };

      Result result = await DioClient().post('Motor/DownloadDocument', details,
          token: token, isPostData: true, isHeaderJsonType: true);
      if (result is SuccessState) {
        DownloadDocumentModel res =
            DownloadDocumentModel.fromJson(result.value);
        Utils.saveALLRecords(
            res.buffer, i, response.documentDetails[i].documentType);
        downloadAllDocuments(response, i + 1);
        if (response.documentDetails.length == i) {
          CustomDialogHelper.showAlertDialog(
              title: "Alert",
              description: "ALL Document downloaded successfully",
              okBtnFunction: () {
                Get.back();
              });
        }
      } else if (result is ErrorState) {
        errorMessage(result.msg);
      }
    }
  }
}
