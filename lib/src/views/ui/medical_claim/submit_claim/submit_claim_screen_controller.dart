import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/claimant_details_model.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/enter_claim_details_controller.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitClaimScreenXController extends GetxController {
  final formKey = GlobalKey<ExpansionTileCardState>();
  final documentFormKey = GlobalKey<ExpansionTileCardState>();

  bool isEnterClaimViewExpanded = true;
  bool isUploadDocumentExpanded = true;
  bool isDetailsAdded = false;
  bool filedUploaded = false;
  String savedRequestId;

  String token;
  String companyID;

  List<ClaimantDetails> totalClaimants = [];

  @override
  void onInit() {
    // getToken();

    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    var getCompanies = await _sharedPreferencesHelper.getCompanyId;
    List obj = json.decode(getCompanies);
    try {
      var company =
          obj.firstWhere((element) => element["Name"] == "Global ITs");
      companyID = company["Id"].toString();
    } catch (e) {
      if (obj.length > 0) companyID = obj.first["Id"].toString();
    }

    getMedicalClaimats();
  }

  togglClaimView() {
    if (isEnterClaimViewExpanded) {
      isEnterClaimViewExpanded = false;
    } else {
      isEnterClaimViewExpanded = true;
    }
    update();
  }

  void getMedicalClaimats() async {
    Result result =
        await DioClient().get('Medical/Cards?companyId=$companyID', token);

    if (result is SuccessState) {
      var jsonData = List<ClaimantDetails>.from(
          result.value.map((x) => ClaimantDetails.fromJson(x)));
      if (jsonData is List<ClaimantDetails>) {
        totalClaimants = jsonData;
        Get.find<EnterClaimDetailsXController>().getClaimatDetails();
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      // errorMessage(result.msg.error.toString());
    }
  }

  updateDetailView() {
    isEnterClaimViewExpanded = true;
    update();
  }
}
