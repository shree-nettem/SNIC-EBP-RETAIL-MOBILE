import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_saving_beneficiares.dart/saving_beneficiries_model.dart';
import 'package:ebpv2/src/views/ui/group_life/models/get_benificiaries_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingBeneficiaryXController extends GetxController {
  RxBool hideAddBenificiaryScreen = true.obs;

  // List<double> totalPercentages = [20, 20, 60];

  List<GhadyBeneficiary> totalBenificiaries = [];

  RxBool isSaveOn = false.obs;
  String token;
// used to show error msg when user cliked save button
  RxBool hidePercentageText = true.obs;

  shareEqualPercetages() {
    totalBenificiaries = totalBenificiaries.map<GhadyBeneficiary>((element) {
      element.beneficiaryPercentage =
          // double.parse((
          100.0 / totalBenificiaries.length;
      // ).toStringAsFixed(1));
      return element;
    }).toList();
    isSaveOn.value = true;
    update();
  }

  double getViewHeight(BuildContext context) {
    return Get.height - 225 - MediaQuery.of(context).viewInsets.bottom;
  }

  bool checkTotalPercentageIsequal100() {
    if (totalBenificiaries.length == 0) {
      return true;
    }

    double finalPercenntage = 0.0;
    totalBenificiaries.forEach((element) {
      finalPercenntage += element.beneficiaryPercentage ?? 0.0;
    });
    togglePercentageText(true);
    return finalPercenntage == 100 ? true : false;
  }

  void togglePercentageText(bool boolValue) {
    hidePercentageText.value = boolValue;
    // update();
  }

  double getCurrentPercentage() {
    double finalPercenntage = 0.0;
    totalBenificiaries.forEach((element) {
      finalPercenntage += element.beneficiaryPercentage;
    });
    togglePercentageText(true);
    return finalPercenntage;
  }

  void backActionClicked(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (hideAddBenificiaryScreen.value == false) {
      changeBenificiaryUI();
    } else {
      Get.back();
    }
  }

  changeBenificiaryUI() {
    hideAddBenificiaryScreen.toggle();
    update();
  }

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
    getBeificiaries();
  }

  getBeificiaries() async {
    Result result = await DioClient().get(
        'Saving/GetUncompletedRequestInput?productCode=SS01RE', token,
        isLoading: false);
    if (result is SuccessState) {
      var jsonData = GhadyBeneficiriesModel.fromJson(result.value);
      if (jsonData.inputs.beneficiaries != null) {
        var benficiariesjsonData = jsonData.inputs.beneficiaries.toList();

        if (benficiariesjsonData is List<GhadyBeneficiary>) {
          totalBenificiaries = benficiariesjsonData;
          update();
        }
      }
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.error.toString());
    }
  }

  saveBenificiaries() async {
    var beneficiaryData =
        List<dynamic>.from(totalBenificiaries.map((x) => x.toJson()));

    var customData = {
      "ID": "28e35683-94f6-4503-b5a1-0b88ec30d4a8",
      "RequestID": 5336,
      "ProductName": "Retirement Saving Plan",
      "ProductCode": "SS01RE",
      "ProductCategory": "SNIC-SAVING01",
      "Amount": 234,
      "PaymentFrequency": 1,
      "Installments": 228,
      "PaymentMethod": 1,
      "Currency": "BHD",
      "Description": null,
      "Status": 0,
      "Product": {
        "age": 36,
        "gender": "m",
        "frequency": 1,
        "lumpsum": 0,
        "target": 97557,
        "customerTarget": 97557,
        "terms": 19,
        "index": 1,
        "amount": 234,
        "strategyValue": 5,
        "isAmountBased": true,
        "insuranceType": 1,
        "witdrawals": [],
        "witdrawalYears": [],
        "lockTerms": false,
        "lockTarget": false,
        "lastStep": 4,
        "lastStage": 2,
        "facts": {
          "Age": 35,
          "SpouseAge": 44,
          "RetirementAge": 54,
          "SpouseRetirementAge": 55,
          "Expenses": 300,
          "Saving": 0,
          "SavingInterestRate": 0,
          "EndOfServiceIndemnity": 0,
          "MonthlyPension": 0,
          "SpouseMonthlyPension": 1000,
          "YearlyPostRetirement": 0,
          "IncludeSpouse": false,
          "SalaryIncreaseRate": 0,
          "ExpensesIncreaseRate": 0,
          "ExpensesRelated": 0,
          "LifeExpectancy": 80,
          "PostRetirementSpendingRate": 1,
          "IncludeMonthlyPension": true,
          "IncludeEndOfServiceIndemnity": true,
          "IsAddLumpsum": false,
          "IncludeSaving": false,
          "TempSaving": 0,
          "TempMonthlyPension": 0,
          "TempEndOfServiceIndemnity": 0
        },
        "step": 4,
        "investorType": "Adventurous",
        "recommendedInvestorType": "Cautious",
        "answers": [0, 0, 0, 0, 0, 0],
        "plan": "Retirement Saving Plan",
        "client": "HAMAD HASAN ALMOSAWI",
        "GrowthRate": 0.07,
        "beneficiaries": beneficiaryData,
        "stage": 2
      }
    };

    Result result = await DioClient().post('Saving/SaveRequest', customData,
        token: token, isPostData: true, isHeaderJsonType: true);
    // Get.back();

    if (result is SuccessState) {
      getBeificiaries();
      successMessage("records_saved".tr);
      isSaveOn.value = false;
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
      // errorMessage(result.msg.error.toString());
    }
  }
}
