import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iban/iban.dart';
import 'package:intl/intl.dart';

import '../claimant_details_model.dart';
import '../currency_list_model.dart';
import '../submit_claim_screen_controller.dart';

class EnterClaimDetailsXController extends GetxController {
  final formKey = GlobalKey<FormState>();

  List<ClaimantDetails> totalClaimant;
  List<String> totalClaimantNames;

  TextEditingController treatmentDateController,
      totalClaimedAmountController,
      medicalProviderController,
      countryController,
      remarksController,
      ibanController;

  String claim, claimerNationality = "select".tr;
  int selectedClaimatIndex = 0;
  String token;
  String savedRequestID = "0";

  List<String> totalCurrency = ['BHD'];
  String selectedCurrency = 'BHD';

  void setNationality(String nationality) {
    this.claimerNationality = nationality;
  }

  @override
  void onInit() {
    treatmentDateController = TextEditingController();
    totalClaimedAmountController = TextEditingController();
    medicalProviderController = TextEditingController();
    countryController = TextEditingController();
    remarksController = TextEditingController();
    ibanController = TextEditingController();
    ibanController.addListener(() {
      final text = ibanController.text;
      // if (text.length == 20) {
      ibanController.value =
          ibanController.value.copyWith(text: toPrintFormat(text));
      // } else {
      //   ibanController.value = ibanController.value.copyWith(text: text);
      // }
      ibanController.selection = TextSelection.fromPosition(
          TextPosition(offset: ibanController.text.length));
    });

    // sourceOfIncomeOptions = ["Select", "Salaried", "SelfEmployed"];
    totalClaimantNames = ["select".tr];
    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getCurrencyList();
    // var getCompanies = await _sharedPreferencesHelper.getCompanyId;
    // List obj = json.decode(getCompanies);
    // var company = obj.firstWhere((element) => element["Name"] == "Global ITs");
    // companyID = company["Id"].toString();
    // getMedicalClaimats();
  }

  void getClaimatDetails() {
    totalClaimant = Get.find<SubmitClaimScreenXController>().totalClaimants;
    totalClaimantNames =
        totalClaimant.map((element) => element.insuredMemberName).toList();
  }

  void setClaim(String claim) {
    totalClaimant.map((e) {
      if (e.insuredMemberName == claim) {
        selectedClaimatIndex = totalClaimant.indexOf(e);
      }
    });
  }

  @override
  void onClose() {
    treatmentDateController.dispose();
    totalClaimedAmountController.dispose();
    medicalProviderController.dispose();
    countryController.dispose();
    remarksController.dispose();
    ibanController.dispose();
    super.onClose();
  }

  getCurrencyList() async {
    Result result = await DioClient().get('Medical/GetCurrency', token);

    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }

      var currencyJson = CurrencyList.fromJson(result.value);
      var jsonData =
          List<CurrencyResult>.from(currencyJson.result.map((x) => x));
      if (jsonData is List<CurrencyResult>) {
        var currencies = jsonData.map((x) => x.value).toList();
        if (currencies.length > 1) totalCurrency = currencies;
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  clearSavedData() {
    claimerNationality = "select".tr;
    selectedClaimatIndex = 0;
    savedRequestID = "0";

    selectedCurrency = 'BHD';
    treatmentDateController.clear();
    totalClaimedAmountController.clear();
    medicalProviderController.clear();
    countryController.clear();
    remarksController.clear();
    ibanController.clear();
  }

  //SAVE PROFILE DATA API CALL
  saveProfileData() async {
    var details = {
      "RequestID": int.parse(savedRequestID), //0 for create, other for update
      "Amount": totalClaimedAmountController.text,
      "ApprovedAmount": null,
      "RequestDate": DateTime.now().toString(),
      "Status": 0, //1 for draft, fixed
      "ReferenceID": null,
      "Currency": selectedCurrency,
      "Product": {
        "ClaimantID": totalClaimant[selectedClaimatIndex].identityId,
        "Relation": totalClaimant[selectedClaimatIndex].relation,
        "DateOfBirth":
            totalClaimant[selectedClaimatIndex].dateOfBirth.toString(),
        "IDNumber": totalClaimant[selectedClaimatIndex].identityId,
        "CardNumber": totalClaimant[selectedClaimatIndex].lifeCode,
        // "ClaimID": 0,
        "MedicalProvider": medicalProviderController.text,
        "Country": claimerNationality,
        "CompanyNName": "Global ITs",
        "IBAN": ibanController.text,
        "DateOfClaim": treatmentDateController.text != ""
            ? DateFormat("dd-MM-yyyy")
                .parse(treatmentDateController.text)
                .toString()
            : null,
        "Notes": remarksController.text
      }
    };
    print(details);
    Result result = await DioClient().post('Medical/SaveClaim', details,
        token: token, isPostData: true, isHeaderJsonType: true);

    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }
      if (result.value["RequestID"] != null) {
        Get.find<SubmitClaimScreenXController>().savedRequestId =
            result.value["RequestID"].toString();
        savedRequestID = result.value["RequestID"].toString();
        Get.find<SubmitClaimScreenXController>().isDetailsAdded = true;
        Get.find<SubmitClaimScreenXController>()
            .formKey
            .currentState
            .collapse();
      }

      update();
    } else if (result is ErrorState) {}
  }
}
