import 'dart:convert';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculate_premium.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculating_premium_renewal_flow.dart';
import 'package:ebpv2/src/views/ui/motor/model/issue_quote.dart';
import 'package:ebpv2/src/views/ui/motor/model/motor_switch_plan.dart';
import 'package:ebpv2/src/views/ui/motor/model/renew_plan_details.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/screen/review_policy.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'motor_renewal_controller.dart';

class RenewSwitchController extends GetxController {
  //current page number
  int pageNo = 0;
  RxInt selectedIndex = 0.obs;
  List<String> eligibleUpgradeList = ["SELECT"];
  String token;
  RxBool isPlanSwitchedAndQuoteIssue = false.obs;

  //recommended tag for a plan
  bool isRecommendedVisible,
      isSwitchFlowselected,
      isSupplementaryBenifitsVisible,
      isPolicyfees,
      isVatVisible,
      isDiscountVisilbe;
  RxString eligibleOption = "SELECT".obs, selectedBankName = 'SELECT'.obs;
  IssueQuote issedQuote;
  SwitchPlan switchPlan;

  //horizontal scroll controller for plans
  final AutoScrollController scrollController = new AutoScrollController();
//total premium variables
  RxDouble total = 0.0.obs,
      supplimentBenifitTotal = 0.0.obs,
      vat = 0.0.obs,
      policyFees = 0.0.obs;

  //response for calculate premium
  CalculatingPremium premium;

  bool isPlanSelected;

  @override
  void onInit() {
    isRecommendedVisible = false;
    isPlanSelected = false;
    isSupplementaryBenifitsVisible = true;
    isPolicyfees = true;
    isVatVisible = true;
    isDiscountVisilbe = true;
    getToken();
    super.onInit();
  }

  //scroll to previous plan
  void scrollToPreviousPage() {
    if (pageNo != 0) {
      this.pageNo = pageNo - 1;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle,
          duration: Duration(milliseconds: 300));
      setSelectedPlan(pageNo);
      update();
    }
  }

//scroll to next plan
  void scrollToNextPage() {
    if (pageNo >= 0 && pageNo < 4) {
      this.pageNo = pageNo + 1;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle,
          duration: Duration(milliseconds: 600));
      setSelectedPlan(pageNo);

      update();
    }
  }

  //save the slected plan  index for further use
  void setSelectedPlan(int index) {
    selectedIndex.value = index;
    eligibleOption.value = "SELECT";
    eligibleUpgradeList = [eligibleOption.value];
    eligibleUpgradeList.addAll(switchPlan
        .result[selectedIndex.value].eligibleUpgrades
        .map((e) => e.label));
  }

  //select the current plan
  void setPlanSelected() {
    isPlanSelected = true;
    update();
  }

  //calculation of supplimentary benifits of corresponding plans
  String calculateSupplementaryBenifitsTotal() {
    supplimentBenifitTotal.value = 0.0;
    if (switchPlan != null) {
      switchPlan.result[selectedIndex.value].optionalCovers.forEach((element) {
        supplimentBenifitTotal.value = element.isSelected
            ? element.price + supplimentBenifitTotal.value
            : supplimentBenifitTotal.value + 0.0;
      });
    }
    if (eligibleOption.value != "SELECT") {
      supplimentBenifitTotal.value += switchPlan
          .result[selectedIndex.value].eligibleUpgrades
          .where((e) => e.label == eligibleOption.value)
          .first
          .price;
    }

    return supplimentBenifitTotal.toString();
  }

  //add suppliment benifits to the plan
  switchSupplimentBenifits(index) {
    for (int i = 0;
        i < switchPlan.result[selectedIndex.value].optionalCovers.length;
        i++) {
      if (index == i &&
          switchPlan.result[selectedIndex.value].optionalCovers[i].isSelected) {
        switchPlan.result[selectedIndex.value].optionalCovers[i].isSelected =
            false;
      } else if (index == i &&
          !switchPlan
              .result[selectedIndex.value].optionalCovers[i].isSelected) {
        switchPlan.result[selectedIndex.value].optionalCovers[i].isSelected =
            true;
      }
    }
    calculateTotalPremeium();
    update();
  }

  //calculate total premium
  String calculateTotalPremeium() {
    //policy fees need to updated
    total.value = 0.0;
    policyFees.value = 0.0;
    vat.value = 0.0;
/*
    policyFees.value = double.parse(switchPlan.result[selectedIndex.value].
    calculatePremiumOutput.policyDetail
        .nameValues.where((element) => element.strName=='Fees').first.strValue);*/

    var suplimentaryBenifitTotal =
        double.parse(calculateSupplementaryBenifitsTotal());
    policyFees.value =
        double.parse(switchPlan.result[selectedIndex.value].policyFees);

    vat.value += (((double.parse(
                    switchPlan.result[selectedIndex.value].strBasicPremium) +
                suplimentaryBenifitTotal +
                policyFees.value) *
            10) /
        100);

    total.value = (suplimentaryBenifitTotal +
        policyFees.value +
        vat.value +
        double.parse(switchPlan.result[selectedIndex.value].strBasicPremium));

    return total.value.toStringAsFixed(3);
  }

  //get eligible plans for user
  void getSwitchPlan(String quotationNumber, String policyIDate,
      CalculatingPremium detail) async {
    final MotorRenewalXController controller = Get.find();
    var data = {
      "PolicyStartDate": policyIDate,
      "QuoteNumber": quotationNumber,
      "PlateNumber": null
    };

    res.Result result = await DioClient()
        .post('/Motor/GetRenewalEligiblePlan', data, token: token);
    if (result is res.SuccessState) {
      switchPlan = SwitchPlan.fromJson(result.value);
      eligibleOption.value = "SELECT";
      eligibleUpgradeList = [eligibleOption.value];
      eligibleUpgradeList.addAll(switchPlan
          .result[selectedIndex.value].eligibleUpgrades
          .map((e) => e.label));

      try {
        eligibleOption.value = eligibleUpgradeList
            .firstWhere((element) =>
                element.toLowerCase().contains(
                    controller.planDetails.carReplace.toLowerCase()) &&
                element.contains(controller.planDetails.carReplaceDays))
            .toString();
      } catch (e) {
        eligibleOption.value = "SELECT";
      }
      controller.isReleaseletterViewVisibile = false;
      controller.isPlanViewVisible = true;
      controller.isPaymentViewVisible = false;
      controller.isSwitchFlowselected = false;
      Get.toNamed(AppRoutes.SWITCH_PLAN);
    } else if (result is res.ErrorState) {
      ErrorResponse error = ErrorResponse.fromJson(result.msg);
      // Get.back();
      errorMessage(error.message);
    }
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //calculating premium if user switched plan
  Future<void> getCalculatingPremium(
      {String policyIDate, String quotationNumber, String policySi}) async {
    final MotorRenewalXController controller = Get.find();
    print(switchPlan.toString());
    var data = {
      "PolicyStartDate": policyIDate,
      "SumInsured": double.parse(policySi.replaceAll(",", "")).toInt(),
      "QuoteNumber": controller.premium.quotationNumber,
      "CarReplacement": eligibleOption.value != 'SELECT'
          ? switchPlan.result[selectedIndex.value].eligibleUpgrades
              .where((element) => element.label == eligibleOption.value)
              .first
              .value
          : "",
      "PlanName": switchPlan != null
          ? switchPlan.result[selectedIndex.value].planName
          : controller.detail.planName,
      "BankName": null,
      "PlateNumber": controller.detail.registrationNo,
      "Mortgage": controller.detail.isMortgage,
    };
    if (switchPlan != null) {
      switchPlan.result[selectedIndex.value].optionalCovers.forEach((element) =>
          data.putIfAbsent(element.value, () => element.isSelected.toString()));
    }
    res.Result result = await DioClient().post(
        '/Motor/CalculatingPremium', data,
        token: token, isPostData: true);
    if (result is res.SuccessState) {
      issueQuote(controller.premium.quotationNumber);
    } else if (result is res.ErrorState) {
      // ErrorResponse error = ErrorResponse.fromJson(result.msg);
      Get.back();
      errorMessage(result.msg.toString());
      // errorMessage(error.message);
    }
  }

  // issue quote for plan renewal
  Future<void> issueQuote(String quotationNumber) async {
    var data = {
      "proposalNumber": quotationNumber,
    };

    res.Result result = await DioClient()
        .post('Motor/issueQuoteRenewal', data, token: token, isPostData: true);
    if (result is res.SuccessState) {
      MotorRenewalXController controller = Get.find();
      issedQuote = IssueQuote.fromJson(result.value);
      isPlanSwitchedAndQuoteIssue.value = true;

      Get.toNamed(AppRoutes.SWITCH_PLAN);
      controller.update();
    } else if (result is res.ErrorState) {
      ErrorResponse error = ErrorResponse.fromJson(result.msg);
      // Get.back();
      errorMessage(error.message);
    }
  }
}
