import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/credentials.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculate_premium.dart';
import 'package:ebpv2/src/views/ui/motor/model/e_gov_model.dart';
import 'package:ebpv2/src/views/ui/motor/model/issue_quote.dart';
import 'package:ebpv2/src/views/ui/motor/model/personal_verification.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/upload_document_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jumio_mobile_sdk_flutter/jumio_mobile_sdk_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert' as converter;

import '../../../../../router/app_routes.dart';
import '../../../auth/verification/verification_response_model.dart';

class MotorPalnXController extends GetxController {
  // final formKey = GlobalKey<FormState>();

  //current page number
  int pageNo = 0;
  RxInt selectedIndex = 0.obs;

  //token for api calls
  String token, quotationNumer;

  final MotorXController motorXController = Get.find();
  PersonalVerification verification;
//total premium variables
  RxDouble total = 0.0.obs,
      supplimentBenifitTotal = 0.0.obs,
      vat = 0.0.obs,
      policyFees = 0.0.obs;

  //flow control variables
  bool isCashFlowVisible,
      isQuotIssued,
      isPlanSelected,
      isLoanFlowVisible,
      isCustomerFlowVisible,
      isBankFlowVisible;

  //saved data variable
  var savedDraftResponse;

  //horizontal scroll controller for plans
  final AutoScrollController scrollController = new AutoScrollController();

  List<bool> paymentType, ownership;
  TextEditingController vehicleNumber, chassisNumber;
  // TextEditingController eGovExpieryDate;

  //recomended tag for a plan
  bool isRecommendedVisible;

  //eligible options policy fees
  RxString eligibleOption = "SELECT".obs, selectedBankName = 'SELECT'.obs;
  List<String> eligibleUpgradeList = ["SELECT"];

  //response for calculate premium
  CalculatePremium premium;
  CalculatePremium issuedQuotePremium;

  Rx<IssueQuote> quote = Rx<IssueQuote>(IssueQuote());
  String userId;

  @override
  void onInit() {
    resettingValuetoOriginal();
    getToken();

    vehicleNumber = TextEditingController();
    chassisNumber = TextEditingController();

    // eGovExpieryDate = TextEditingController();
    super.onInit();
  }

  resettingValuetoOriginal() {
    isCashFlowVisible = false;
    isQuotIssued = false;
    isPlanSelected = false;
    isLoanFlowVisible = false;
    isCustomerFlowVisible = false;
    isBankFlowVisible = false;
    quotationNumer = "";
    paymentType = [false, false];
    ownership = [false, false];
  }

  //add supplimantery benifits to the plan
  switchSupplimentBenifits(index) {
    for (int i = 0;
        i < premium.data[selectedIndex.value].optionalCovers.length;
        i++) {
      if (index == i &&
          premium
              .data[selectedIndex.value].optionalCovers[i].isSelected.value) {
        premium.data[selectedIndex.value].optionalCovers[i].isSelected.value =
            false;
      } else if (index == i &&
          !premium
              .data[selectedIndex.value].optionalCovers[i].isSelected.value) {
        premium.data[selectedIndex.value].optionalCovers[i].isSelected.value =
            true;
      }
    }
    if (premium.data[selectedIndex.value].calculatePremiumOutput != null)
      premium.data[selectedIndex.value].hasCalculatePremium.value = false;
    //calculating premium and total every time user makes a change and ui is updated
    calculateSupplementaryBenifitsTotal();
    calculateTotalPremeium();
    // update();
  }

  //add supplementary benefits to the plan
  switchOwnership(index) {
    for (int i = 0; i < ownership.length; i++) {
      ownership[i] = i == index;
    }
    if (ownership[0]) {
      isCustomerFlowVisible = true;
      isBankFlowVisible = false;
    } else if (ownership[1]) {
      isCustomerFlowVisible = false;
      isBankFlowVisible = true;
    }
    update();
  }

  //choose from cash and loan
  switchPaymentType(index) {
    paymentType = [false, false];
    for (int i = 0; i < paymentType.length; i++) {
      paymentType[i] = i == index;
    }
    //mark cash flow selected
    if (paymentType[0]) {
      isCashFlowVisible = true;
      isLoanFlowVisible = false;
    } else {
      isCashFlowVisible = false;
      isLoanFlowVisible = true;
    }
    update();
  }

//scroll to previous plan
  void scrollToPreviousPage() {
    if (pageNo > 0) {
      this.pageNo = pageNo - 1;
      // setSelectedPlan(pageNo);
      // eligibleOption.value = "SELECT";
      // eligibleUpgradeList = [eligibleOption.value];
      // eligibleUpgradeList.addAll(premium
      //     .data[selectedIndex.value].eligibleUpgrades
      //     .map((e) => e.label));

      //calculate benefits and total premeium each time the plan is changed and update ui
      calculateSupplementaryBenifitsTotal();
      calculateTotalPremeium();
      // update();
    }
  }

//scroll to next plan
  void scrollToNextPage() {
    if (pageNo >= 0 && pageNo < premium.data.length - 1) {
      this.pageNo = pageNo + 1;

      // setSelectedPlan(pageNo);
      // eligibleOption.value = "SELECT";
      // eligibleUpgradeList = [eligibleOption.value];
      // eligibleUpgradeList.addAll(premium
      //     .data[selectedIndex.value].eligibleUpgrades
      //     .map((e) => e.label));

      //calculate benefits and total premeium each time the plan is changed and update ui
      calculateSupplementaryBenifitsTotal();
      calculateTotalPremeium();
      update();
    }
  }

  //select the current plan
  void setPlanSelected() {
    isPlanSelected = true;
    update();
  }

  @override
  void onClose() {
    vehicleNumber.dispose();
    chassisNumber.dispose();
    super.onClose();
  }

  //save the slected plan  index for further use
  void setSelectedPlan(int index) {
    selectedIndex.value = index;

    // update();
  }

  onBackPressed() {
    if (motorXController.draftProgressStatus[2].status == 1) {
/*      motorXController.draftProgressStatus[2].status=0;
      motorXController.expansionCardKey[2].currentState.collapse();
      motorXController.draftProgressStatus[1].status=1;
      postDraft(callCalculatePremium: true);*/
      Get.back();
    } else if (isQuotIssued) {
      UploadDocumentController uploadDocumentController = Get.find();
      isQuotIssued = false;
      uploadDocumentController.isDealerQuotionUploaded.value = false;
      quotationNumer = "";
      postDraft(callCalculatePremium: true);
      update();
    } else if (isCashFlowVisible || isLoanFlowVisible) {
      if (isCashFlowVisible) {
        isCashFlowVisible = false;
      } else if (isLoanFlowVisible) {
        isLoanFlowVisible = false;
        ownership = [false, false];
      }
      paymentType = [false, false];
      isPlanSelected = false;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle,
          duration: Duration(milliseconds: 800));
      update();
    } else if (isPlanSelected) {
      isPlanSelected = false;
      update();
    } else {
      Get.back();
    }
  }

  //next button operation under cash flow
  void cashNextButton() {
    motorXController.expansionCardKey[1].currentState.collapse();

    motorXController.draftProgressStatus[1].status = 2;
    motorXController.draftProgressStatus[2].status = 1;

    postDraft(callCalculatePremium: true);
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    userId = await _sharedPreferencesHelper.getCustomerId;
    getUserIdentificationStatus();
  }

  //get calculate premeium api call
  getPlanDetails(
      {bool paymentMethodCall,
      bool updateDetails = false,
      bool fromCalculatePremiumtn = false}) async {
    final VehicleDetailsXController vehicleDetailsXController = Get.find();

    //later replace the null chasis number with actual value

    var requestData = {
      "Year": vehicleDetailsXController.makeYear.value,
      "BrandNew": vehicleDetailsXController.isBrandNew[0]
          ? 'BN'
          : vehicleDetailsXController.isBrandNew[1]
              ? 'UC'
              : '',
      "PolicyStartDate": DateTime.parse(
          '${vehicleDetailsXController.policyStartDate.text} 00:00:00.000'),
      "SumInsured": vehicleDetailsXController.motorValue.text,
      "MotorMake": vehicleDetailsXController.makeList
          .where((element) =>
              element.description == vehicleDetailsXController.vehicleMake)
          .first
          .code,
      "MotorModel": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .modelCode,
      "MotorModelBodyType": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .bodyType,
      "MotorModelHp": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .hp,
      "MotorModelSeats": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .seats,
      "MotorModelNumberOfCylender": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .numberofCylender,
      "MotorModelEngineSize": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .engineSize,
      "MotorModelUniqueId": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .uniqueId,
      "MotorModelTypeSpec": vehicleDetailsXController.modelList
          .where((element) =>
              element.model == vehicleDetailsXController.vehicleModel.value)
          .first
          .typeSpec,
      "NoClaimDeclarationPeriod": vehicleDetailsXController.selectedFaultClaim,
      "QuoteNumber": paymentMethodCall
          ? premium.data[selectedIndex.value].calculatePremiumOutput != null
              ? premium.data[selectedIndex.value].calculatePremiumOutput
                  .strPolicyQuoteNumber
              : ""
          : null,
      "PlanName": paymentMethodCall
          ? premium.data[selectedIndex.value].planName
          : fromCalculatePremiumtn
              ? premium.data[selectedIndex.value].planName
              : "",
      "PolicyEndDate": vehicleDetailsXController.policyExpiryDate.text,
      "CarReplacement": eligibleOption.value != 'SELECT'
          ? premium.data[selectedIndex.value].eligibleUpgrades
                  .firstWhere(
                      (element) => element.label == eligibleOption.value)
                  .value ??
              ""
          : "",
      "PlateNumber": paymentMethodCall ? vehicleNumber.text : "",
      "BankName":
          selectedBankName.value != 'SELECT' ? selectedBankName.value : null,
      "ChassisNumber": null
      /*   "ChassisNumber": paymentMethodCall ? chassisNumber.text : "",*/
    };

    if (premium != null) {
      List<EligibleUpgrade> data = premium
          .data[selectedIndex.value].optionalCovers
          .where((e) => e.isSelected.value)
          .toList();
      for (var i = 0; i < data.length; i++) {
        requestData[data[i].value] = true;
      }
    }

    //adding optional covers dynamically based on selected plan
    if (paymentMethodCall && premium != null) {
      premium.data[selectedIndex.value].optionalCovers.forEach((element) =>
          requestData.putIfAbsent(
              element.value, () => element.isSelected.toString()));
    }

    res.Result result = await DioClient().post(
        'Motor/CalculatePremium', requestData,
        token: token,
        isPostData: true,
        showLongWaitingMessage: true,
        description:
            "This can take around 90 seconds \nWe appreciate your patience, \nPlease sit back and relax while we find a best plan for your motor");
    ;
    if (result is res.SuccessState) {
      if (!paymentMethodCall && motorXController.expansionCardKey[0] != null) {
        motorXController.expansionCardKey[0].currentState.collapse();
      }
      var jsonData = CalculatePremium.fromJson(result.value);

      if (jsonData is CalculatePremium) {
        if (!paymentMethodCall) {
          if (fromCalculatePremiumtn) {
            premium.data[selectedIndex.value].calculatePremiumOutput =
                jsonData.data[0].calculatePremiumOutput;
            premium.data[selectedIndex.value].hasCalculatePremium.value = true;
          } else {
            premium = jsonData;
            eligibleOption.value = "SELECT";
            eligibleUpgradeList = [eligibleOption.value];
            print(selectedIndex.value);
            eligibleUpgradeList.addAll(premium
                .data[selectedIndex.value].eligibleUpgrades
                .map((e) => e.label));

            eligibleOption.value = premium
                .data[selectedIndex.value].eligibleUpgrades
                .firstWhere((e) =>
                    e.value == premium.data[selectedIndex.value].defaultUpgrade)
                .label;
          }

          //  value: controller != null
          //     ? controller.premium.data[controller.selectedIndex.value]
          //         .optionalCovers[index].isSelected
          //     : false,
          // onTap: () {
          //   controller != null
          //       ? controller.switchSupplimentBenifits(index)
          //       : null;
          // },

          quotationNumer =
              premium.data[selectedIndex.value].calculatePremiumOutput != null
                  ? premium.data[selectedIndex.value].calculatePremiumOutput
                      .strPolicyQuoteNumber
                  : premium.data[selectedIndex.value].startingFrom.toString();

          if (vehicleDetailsXController.isBrandNew[0]) {
            DateTime startDate = DateFormat("yyyy-MM-dd")
                .parse(vehicleDetailsXController.policyStartDate.text);
            DateTime lastDayOfMonth =
                new DateTime(startDate.year + 1, startDate.month + 1, 0);
            vehicleDetailsXController.policyExpiryDate.text =
                lastDayOfMonth.toString();
          }
          if (vehicleDetailsXController.draftFormat.result.isPlanSelected &&
              updateDetails) {
            if (vehicleDetailsXController
                    .draftFormat.result.selectYourPlanStatus ==
                1) {
              motorXController.expansionCardKey[1].currentState.expand();
            }
            if (vehicleDetailsXController.draftFormat.result.paymentStatus ==
                1) {
              motorXController.expansionCardKey[2].currentState.expand();
            }
            selectedIndex.value =
                vehicleDetailsXController.draftFormat.result.selectedPlanIndex;
            if (!fromCalculatePremiumtn)
              premium.data[selectedIndex.value].optionalCovers
                  .forEach((element) {
                vehicleDetailsXController.draftFormat.optionalCovers
                    .forEach((saved) {
                  if (saved == element.label) {
                    element.isSelected.value = true;
                  }
                });
              });
            // pageNo = selectedIndex.value;
            // scrollController.scrollToIndex(pageNo,
            //     preferPosition: AutoScrollPosition.middle,
            //     duration: Duration(milliseconds: 800));
            // print(vehicleDetailsXController.draftFormat.result.eligibleOption);
            // eligibleOption.value =
            // vehicleDetailsXController.draftFormat.result.eligibleOption;
            // update();
          }
          calculateTotalPremeium();

          if (vehicleDetailsXController.draftFormat.result.isQuotIssued) {
            vehicleNumber.text =
                vehicleDetailsXController.draftFormat.result.plateNumber;
            chassisNumber.text =
                vehicleDetailsXController.draftFormat.result.chassisNumber;
          }
        } else {
          issuedQuotePremium = jsonData;
        }

        // motorXController.update();

        if (paymentMethodCall) {
          quotationNumer = issuedQuotePremium
              .data[0].calculatePremiumOutput.strPolicyQuoteNumber;
          generateQuote();
        }
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //calculation of supplimentary benifits of corresponding plans
  String calculateSupplementaryBenifitsTotal() {
    double calculateValue = 0.0;
    if (premium != null) {
      premium.data[selectedIndex.value].optionalCovers.forEach((element) {
        calculateValue = element.isSelected.value
            ? element.price + calculateValue
            : calculateValue + 0.0;
      });
      if (eligibleOption.value != "SELECT") {
        try {
          calculateValue += premium.data[selectedIndex.value].eligibleUpgrades
              .where((e) => e.label == eligibleOption.value)
              .first
              .price;
        } catch (e) {}
      }
    }

    if (premium.data[selectedIndex.value].calculatePremiumOutput != null) {
      return premium.data[selectedIndex.value].calculatePremiumOutput
          .strSupplementaryBenefit
          .toString();
    }
    return supplimentBenifitTotal.toString();
  }

  //calculate total premium
  String calculateTotalPremeium() {
    try {
      total.value = 0.0;
      vat.value = 0.0;
      print('index${selectedIndex.value}');
      if (premium.data[selectedIndex.value].calculatePremiumOutput != null) {
        try {
          policyFees.value = double.parse(premium.data[selectedIndex.value]
              .calculatePremiumOutput.policyDetail.nameValues
              .firstWhere((element) => element.strName == 'Fees')
              .strValue);
        } catch (e) {
          policyFees.value = 0.0;
        }

        var suplimentaryBenifitTotal =
            double.parse(calculateSupplementaryBenifitsTotal());
        print("$supplimentBenifitTotal supplimentBenifitTotal");
        vat.value += (((double.parse(premium.data[selectedIndex.value]
                        .calculatePremiumOutput.strBasicPremium) +
                    suplimentaryBenifitTotal +
                    policyFees.value) *
                10) /
            100);

        total.value = (suplimentaryBenifitTotal +
            policyFees.value +
            vat.value +
            double.parse(premium.data[selectedIndex.value]
                .calculatePremiumOutput.strBasicPremium));
        return total.value.toStringAsFixed(3);
      }
      return "0.0";
    } catch (e) {
      premium.data[selectedIndex.value].hasCalculatePremium.value = false;
      return "0.0";
    }
  }

  //generate final quote after calling calculate premium
  generateQuote() async {
    var requestData = {
      "proposalNumber": issuedQuotePremium
          .data[0].calculatePremiumOutput.strPolicyQuoteNumber,
      "remarks": "OK"
    };

    res.Result result = await DioClient()
        .post('Motor/IssueQuote', requestData, token: token, isPostData: true);
    ;
    if (result is res.SuccessState) {
      if (quote != null) {
        quote.value = IssueQuote.fromJson(result.value);
      } else {
        quote = Rx<IssueQuote>(IssueQuote());
        quote.value = IssueQuote.fromJson(result.value);
      }

      if (quote.value.status == 'SUCCESS') {
        isQuotIssued = true;
        postDraft(callCalculatePremium: true);
        // update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  postDraft({bool callCalculatePremium, bool issuedPolicy = true}) async {
    final VehicleDetailsXController vehicleDetailsXController = Get.find();
    final UploadDocumentController documentController = Get.find();
    var startDate = vehicleDetailsXController.policyStartDate.text.isNotEmpty
        ? DateFormat("yyyy-MM-dd")
            .parse(vehicleDetailsXController.policyStartDate.text)
        : DateTime.now();
    DateTime lastDayOfMonth =
        new DateTime(startDate.year + 1, startDate.month + 1, 0);

    savedDraftResponse = {
      "Year": vehicleDetailsXController.makeYear.value,
      "BrandNew": [
        vehicleDetailsXController.isBrandNew[0],
        vehicleDetailsXController.isBrandNew[1]
      ],
      "PolicyStartDate": DateFormat('yyyy-MM-dd').format(DateTime.parse(
          '${vehicleDetailsXController.policyStartDate.text} 00:00:00.000')),
      "PolicyExpiryDate":
          Utils.convertDateTimeDisplay(lastDayOfMonth.toString()),
      "SumInsured": vehicleDetailsXController.motorValue.text,
      "MotorMake": vehicleDetailsXController.vehicleMake,
      "MotorModel": vehicleDetailsXController.vehicleModel.value,
      "NoClaimDeclarationPeriod": vehicleDetailsXController.selectedFaultClaim,
      "QuoteNumber": quotationNumer,
      "PlanName": callCalculatePremium && premium != null
          ? premium.data[selectedIndex.value].planName
          : "",
      "PlateNumber": callCalculatePremium ? vehicleNumber.text : "",
      "BankName": selectedBankName.value,
      "ChassisNumber": callCalculatePremium ? chassisNumber.text : "",
      "selectedPlanIndex": selectedIndex.value,
      "vehicleDetailsStatus": motorXController.draftProgressStatus[0].status,
      "selectYourPlanStatus": motorXController.draftProgressStatus[1].status,
      "paymentStatus": motorXController.draftProgressStatus[2].status,
      "paymentType": paymentType,
      "ownership": ownership,
      "isCashFlowVisible": isCashFlowVisible,
      "isPlanSelected": isPlanSelected,
      "isRecommendedVisible": isRecommendedVisible,
      "isLoanFlowVisible": isLoanFlowVisible,
      "isCustomerFlowVisible": isCustomerFlowVisible,
      "isBankFlowVisible": isBankFlowVisible,
      "isQuotIssued": isQuotIssued,
      "isDealerQuotionUploaded":
          documentController.isDealerQuotionUploaded.value,
      "isCprValid": documentController.isCprValid,
      "eligibleOption": eligibleOption.value,
      "quot": quote != null
          ? quote.value.basicPremiumAmount != null
              ? quote.value.toJson()
              : isQuotIssued
                  ? vehicleDetailsXController.draftFormat.result.quote
                  : null
          : isQuotIssued
              ? vehicleDetailsXController.draftFormat.result.quote
              : null,
      "isPaymentSuccessful": false,
      "isPolicyIssued": issuedPolicy ? true : false
    };
    var optionalCover = [];
    //adding optional covers dynamically based on selected plan
    if (callCalculatePremium && premium != null) {
      premium.data[selectedIndex.value].optionalCovers.forEach((element) => {
            if (element.isSelected.value) {optionalCover.add(element.label)}
          });
    }
    var body = {
      "status_code": 1,
      "message": "success",
      "result": savedDraftResponse,
      "optionalCovers": optionalCover
    };
    res.Result result = await DioClient().post(
        'Customer/SavePreference/MotorPlan', body,
        token: token, isPostData: true, isHeaderJsonType: true);

    if (result is res.SuccessState) {
      if (!callCalculatePremium) {
        getPlanDetails(paymentMethodCall: callCalculatePremium);
      } else {
        motorXController.update();
      }

      /*  if (!paymentMethodCall) {
        motorXController.expansionCardKey[0].currentState.collapse();
        motorXController.draftProgressStatus[0].status = 2;
        motorXController.draftProgressStatus[1].status = 1;
      }
      var jsonData = CalculatePremium.fromJson(result.value);

      if (jsonData is CalculatePremium) {
        if (!paymentMethodCall) {
          premium = jsonData;
          calculateTotalPremeium();
          eligibleUpgradeList.addAll(premium
              .data[selectedIndex.value].eligibleUpgrades
              .map((e) => e.label));
        } else {
          issuedQuotePremium = jsonData;
        }
        motorXController.update();

        if (paymentMethodCall) {
          generateQuote();
        }
      }*/
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void validatePolicydate(String expiryDate) {
    final VehicleDetailsXController vehicleDetailsXController = Get.find();
    DateTime startDate = DateFormat("yyyy-MM-dd")
        .parse(vehicleDetailsXController.policyStartDate.text);
    /*  expiryDate="20221231";
    var strExpiry = expiryDate.split("");
    strExpiry.insert(4, "-");
    strExpiry.insert(7, "-");
    print(strExpiry.join());*/
    // expiryDate = eGovExpieryDate.text;
    // DateTime Expiry = DateFormat("yyyy-MM-dd").parse(eGovExpieryDate.text);

    if (vehicleDetailsXController.isBrandNew[1]) {
      // if (startDate.difference(Expiry).inDays > 1) {
      //   CustomDialogHelper.showCustomDialog(
      //       title: "Error",
      //       description:
      //           "please contact SNIC support team on: EBPSupport@snic.com.bh ",
      //       okBtnFunction: () {
      //         Get.back();
      //       },
      //       cancelBtnFunction: () {
      //         Get.back();
      //       });
      // } else if (Expiry.difference(startDate).inDays >= 0) {
      //   startDate = Jiffy(Expiry).add(days: 1).dateTime;
      //   CustomDialogHelper.showCustomDialog(
      //       title: "Warning ",
      //       description:
      //           "The EGovDueDate ${Utils.convertDateTimeDisplay(Expiry.toString())} "
      //           "is far from policy start date ${vehicleDetailsXController.policyStartDate.text}. "
      //           "The new policy start date has been adjusted "
      //           "to be ${Utils.convertDateTimeDisplay(startDate.toString())}: "
      //           "one day after EGovDueDate",
      //       okBtnFunction: () {
      //         vehicleDetailsXController.policyStartDate.text =
      //             Utils.convertDateTimeDisplay(startDate.toString());
      //         DateTime lastDayOfMonth = new DateTime(
      //             startDate.year + 1, startDate.month, startDate.day);
      //         vehicleDetailsXController.policyExpiryDate.text =
      //             Utils.convertDateTimeDisplay(lastDayOfMonth.toString());
      //         Get.back();
      //         getPlanDetails(paymentMethodCall: true, updateDetails: false);
      //       },
      //       cancelBtnFunction: () {
      //         Get.back();
      //       });
      // } else {
      getPlanDetails(paymentMethodCall: true, updateDetails: false);
      // }
    }
    update();
  }

  Future<void> getEGovt() async {
    //ToDo need to be changed
    var requestBody = {"vehRegistrationNumber": "266708"};
    res.Result result = await DioClient().post(
        'Motor/InsuranceUploadImpl', requestBody,
        token: token, isPostData: true);
    final myTransformer = Xml2Json();
    if (result is res.SuccessState) {
      //  var json = myTransformer.toGData();
      myTransformer.parse(result.value);
      var response = myTransformer.toGData();
      EGovResponse eGovResponse =
          EGovResponse.fromJson(converter.json.decode(response));
      validatePolicydate(eGovResponse
          .soapenvEnvelope
          .soapenvBody
          .retrieveInsurancePolicyResponse
          .retrieveInsurancePolicyReturn
          .insuranceDate
          .t);
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void setBank(String val) {
    selectedBankName.value = val;
  }

  void getUserIdentificationStatus() async {
    res.Result result =
        await DioClient().get('Customer/PersonalVerification', token);

    final myTransformer = Xml2Json();
    if (result is res.SuccessState) {
      //  var json = myTransformer.toGData();
      verification = PersonalVerification.fromJson(result.value);
    }
  }

  void initializeJumio() {
    debugPrint("USER ID $userId");
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
        getVerificationResponse();
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

  /* HIT SET IDENTITY VERIFICATION API */
  Future getVerificationResponse() async {
    showLoading();
    update();
    if (Utils.isInternetConnected() != null) {
      Result result = await DioClient().get(
          'Onboarding/GetVerificationResponse?id=$userId', "",
          isLoading: false);
      if (result is SuccessState) {
        var jsonData = VerificationResponseModel.fromJson(result.value);

        final body = json.decode(jsonData.jumioResponse);
        String jumioVerificationStatus = body['verificationStatus'];

        if (jumioVerificationStatus == "APPROVED_VERIFIED") {
          if (jsonData is VerificationResponseModel &&
              jsonData.benefitResponse != null) {
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
                setExistedProfileAndUser(body);
              } else {
                hideLoading();
                errorMessage("Kindly contact the Administrator");
                update();
              }
            } else {
              hideLoading();
              update();
              errorMessage("No records found from Benefits");
            }
          } else {
            // CALL SAME API, IF IT IS NULL
            getVerificationResponse();
          }
        } else {
          hideLoading();
          update();
          errorMessage("Identity verification has failed. Kindly try again");
        }
      } else if (result is ErrorState) {
        hideLoading();
        update();
        errorMessage(result.msg.toString());
      }
    } else {
      hideLoading();
      update();
      errorMessage("Please connect to the network");
    }
  }

  /* POST THE DATA TO SERVER TO SET THE PROFILE (EXISTING USER) */
  void setExistedProfileAndUser(benefitResponseBody) async {
    String firstName = benefitResponseBody["IGAFeilds"]["firstNameEn"] ?? " ";
    String middleName =
        benefitResponseBody["IGAFeilds"]["middleName1En"] ?? " ";
    String lastName = benefitResponseBody["IGAFeilds"]["lastNameEn"] ?? " ";
    String gender = benefitResponseBody["IGAFeilds"]["gender"] ?? " ";
    String dateOfBirth = benefitResponseBody["IGAFeilds"]["dateOfBirth"] ?? " ";
    String telephoneNumber =
        benefitResponseBody["IGAFeilds"]["telephoneNumber"] ?? " ";
    String email = benefitResponseBody["IGAFeilds"]["email"] ?? " ";
    String addressType = benefitResponseBody["IGAFeilds"]["addressType"] ?? " ";
    String placeOfBirth =
        benefitResponseBody["IGAFeilds"]["placeOfBirth"] ?? " ";
    String nationality = benefitResponseBody["IGAFeilds"]["nationality"] ?? " ";
    String passportNumber =
        benefitResponseBody["IGAFeilds"]["passportNumber"] ?? " ";
    String idNumber = benefitResponseBody["IGAFeilds"]["idNumber"] ?? " ";
    int flatNumber = benefitResponseBody["IGAFeilds"]["flatNumber"] ?? " ";
    int buildingNumber =
        benefitResponseBody["IGAFeilds"]["buildingNumber"] ?? " ";
    String buildingAlpha = benefitResponseBody["IGAFeilds"]["buildingAlpha"];
    int roadNumber = benefitResponseBody["IGAFeilds"]["roadNumber"] ?? " ";
    int blockNumber = benefitResponseBody["IGAFeilds"]["blockNumber"] ?? " ";
    String occupation = benefitResponseBody["IGAFeilds"]["occupation"];
    String employeeName = benefitResponseBody["IGAFeilds"]["nameOfEmployer"];
    // String employeeAddress = benefitResponseBody["IGAFeilds"]["occupation"];

    var setExistProfileRequest = {
      "SavingWithGhady": "",
      "GeneralInsurance": "",
      "ViewingMedicalBenefits": "",
      "MailingAddressTown": "",
      "MailingAddressBlock": "",
      "MailingAddressRoad": "",
      "MailingAddressHouse": "",
      "MailingAddressFlat": "",
      "MailingAddressAlpha": "",
      "HomeAddressTown": "",
      "HomeAddressBlock": "",
      "HomeAddressRoad": "",
      "HomeAddressHouse": "",
      "HomeAddressFlat": "",
      "HomeAddressAlpha": "",
      "SourceOfIncome": "",
      "MonthlyIncome": ""
    };

    Result result = await DioClient().post(
        'Onboarding/SetExistedProfileAndUser?id=$userId',
        setExistProfileRequest,
        isPostData: true,
        isLoading: false);
    if (result is SuccessState) {
      Get.back();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  showLoading(
      {bool showLongWaitingMessage = false,
      String tittle = "",
      String description = ""}) {
    CustomDialogHelper.showLoading(
        showLongWaitingMessage: showLongWaitingMessage,
        description: description);
  }

  hideLoading() {
    CustomDialogHelper.hideLoading();
  }
}
