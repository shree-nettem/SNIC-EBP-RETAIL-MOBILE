import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_loader.dart';
import 'package:ebpv2/src/views/ui/group_life/benefits/benifites_model.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/claimant_details_model.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/medical_group_network_controller.dart';
import 'package:collection/collection.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/customer_medical_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalTabbleOfBenefitsXController extends GetxController {
  List<BenefitsModel> totalBenefits = [];
  List<BenefitsModel> totalTOBSections = [];
  List<BenefitsSubSection> headerTOBSections = [];
  List<BenefitsSubSection> bottomTOBSections = [];
  String titleTOB;

  ContactSupport contactSupport;

  String selectImage(String type) {
    switch (type) {
      case "HE02":
        return Images.illness_on_bed;
        break;
      case "HE03":
        return Images.patient;
        break;
      case "HE04":
        return Images.location_blue;
        break;
      case "HE06":
        return Images.metro_heartbeat;
        break;
      case "In-Patient & Day care":
        return Images.illness_on_bed;
        break;
      case "Maternity":
        return Images.fetus;
        break;
      case "Out-Patient":
        return Images.patient;
        break;
      case "Dental & Optical":
        return Images.dental;
        break;
      case "Travel Services":
        return Images.aeroplane;
        break;
      case "Prevention & wellbeing":
        return Images.heart_with_plus;
        break;
      case "Death & Accidental Critical illness":
        return Images.death_by_cause;
        break;
      case "Alternative Medicine":
        return Images.alternative_medicine;
        break;

      default:
        return "NoImage";
    }
  }

  String token;
  String companyID;

  List<ClaimantDetails> totalClaimants = [];
  RxList<bool> checkedBoxData = RxList();
  bool lang = false;

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

    lang = await _sharedPreferencesHelper.getLang;
    debugPrint("LANGUAGE CODE $lang");
    getMedicalClaimats();
    getBenefits();
  }

  // afterloadig() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getBenefits();
  //   });
  // }

  getBenefits() async {
    Result result = await DioClient().get('Medical/CustomerTOB', token);
    if (result is SuccessState) {
      try {
        var jsonData = List<BenefitsModel>.from(
            result.value.map((x) => BenefitsModel.fromJson(x)));
        if (jsonData is List<BenefitsModel>) {
          totalBenefits = jsonData;

          gettingMedicalTOBData(totalBenefits);
        }
      } catch (e) {
        successMessage("something_went_wrong".tr);
      }
    } else if (result is ErrorState) {
      // Get.back();
      // errorMessage(result.msg.error.toString());
    }
  }

  // getting group life terms data from api

  void gettingMedicalTOBData(List<BenefitsModel> totalObjects) {
    totalObjects.forEach((element) {
      if (element.subSections.length > 0) if (element.subSections[0].ref
          .contains("HE")) {
        if (element.subSections[0].ref == "HE01") {
          titleTOB = element.subSections[0].value.split(" ").first;
        }

        element.subSections.removeAt(0);
        if (element.subSections.length > 3) {
          headerTOBSections = element.subSections
              .where((element) =>
                  element.ref == "HE06" ||
                  element.ref == "HE02" ||
                  element.ref == "HE03" ||
                  element.ref == "HE04")
              .toList();
          bottomTOBSections = element.subSections
              .where(
                  (element) => element.ref == "HE07" || element.ref == "HE08")
              .toList();

          var medicalNetwork = element.subSections
              .where((element) =>
                  element.ref == "HE09" ||
                  element.ref == "HE10" ||
                  element.ref == "HE11")
              .toList();
          Get.find<MedicalGroupNetwornXController>().medicalNetwork =
              medicalNetwork;
          // element.subSections.removeRange(elementsLength - 3, elementsLength);
          // totalTOBSections = element.subSections;
        }
      } else {
        if (!element.subSections[0].ref.contains("LI"))
          totalTOBSections.add(element);
      }
    });

    update();
  }

  void getMedicalClaimats() async {
    Result result = await DioClient()
        .get('Medical/Cards?companyId=$companyID', token, isLoading: false);

    if (result is SuccessState) {
      var jsonData = List<ClaimantDetails>.from(
          result.value.map((x) => ClaimantDetails.fromJson(x)));
      if (jsonData is List<ClaimantDetails>) {
        totalClaimants = jsonData;
        checkedBoxData.value =
            List<bool>.generate(totalClaimants.length, (i) => false);
        // totalClaimants.map((e) => print(e));
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.error.toString());
    }
  }

  updateCheckBox(bool value, int index) {
    checkedBoxData[index] = value;
    update();
  }

  String getEndPointString() {
    var totalIndices = [];
    String endPoint = '';
    checkedBoxData.mapIndexed((index, element) {
      if (element == true) {
        totalIndices.add(index);
      }
    }).toList();

    if (totalIndices.length > 0) {
      totalIndices.map((e) {
        if (endPoint.isEmpty) {
          endPoint = endPoint + "beneficiaries=${totalClaimants[e].identityId}";
        } else {
          endPoint =
              endPoint + "&beneficiaries=${totalClaimants[e].identityId}";
        }
      }).toList();
      return endPoint;
    } else {
      return '';
    }
  }
}
