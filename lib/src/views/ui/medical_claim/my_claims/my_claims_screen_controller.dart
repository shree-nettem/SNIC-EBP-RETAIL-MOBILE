import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/medical_claims_list_model.dart';
import 'package:ebpv2/src/views/ui/motor/model/ClaimHistory.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyClaimsScreenXController extends GetxController {
  List<ClaimHistory> totalExisitingMotorPlan;
  String token;
  RxBool lang = false.obs;
  RxList<MedicalClaimsListModel> totalExistingMedicalClaims =
      RxList<MedicalClaimsListModel>();

  List<MedicalClaimsListModel> originalExistingMedicalClaims;

  RxList<ClaimHistory> claimHistoryList = RxList<ClaimHistory>();
  List<String> medicalListFilters = [
    "filterBy".tr,
    'draft'.tr,
    'submitted'.tr,
    'processing'.tr,
    'approved'.tr,
    'rejected'.tr
  ];
  List<String> motorListFilters = [
    "filterBy".tr,
    "pendingPayment".tr,
    'claimRegistered'.tr,
    'underProcess'.tr,
    'rejected'.tr
  ];

  List<String> bothListFilters = [
    "filterBy".tr,
    'draft'.tr,
    'submitted'.tr,
    'processing'.tr,
    'approved'.tr,
    'rejected'.tr,
    "pendingPayment".tr,
    'claimRegistered'.tr,
    'underProcess'.tr,
  ];

  RxString selectedFilter = "filterBy".tr.obs;
  int selectedIndexFilter = 10;

  filterChanged(String filter, String decider) {
    selectedFilter.value = filter;
    if (selectedFilter.value == "filterBy".tr) {
      selectedIndexFilter = 10;
    } else if (selectedFilter.value == "draft".tr) {
      selectedIndexFilter = 0;
    } else if (selectedFilter.value == "submitted".tr) {
      selectedIndexFilter = 1;
    } else if (selectedFilter.value == "processing".tr) {
      selectedIndexFilter = 2;
    } else if (selectedFilter.value == "approved".tr) {
      selectedIndexFilter = 3;
    } else if (selectedFilter.value == "rejected".tr) {
      selectedIndexFilter = 4;
    } else if (selectedFilter.value == "pendingPayment".tr) {
      selectedIndexFilter = 5;
    } else if (selectedFilter.value == "claimRegistered".tr) {
      selectedIndexFilter = 6;
    } else if (selectedFilter.value == "underProcess".tr) {
      selectedIndexFilter = 7;
    }
    refreshedData(decider);
  }

  refreshedData(String decider) {
    print(totalExisitingMotorPlan.length);
    if (selectedIndexFilter == 10) {
      print(totalExisitingMotorPlan.length);
      totalExistingMedicalClaims.value = originalExistingMedicalClaims;
      claimHistoryList.value = totalExisitingMotorPlan;
    } else {
      var filteredData = originalExistingMedicalClaims
          .where((i) => i.status == selectedIndexFilter)
          .toList();

      totalExistingMedicalClaims.value = filteredData;

      var motorFilteredData = totalExisitingMotorPlan
          .where(
              (i) => i.statusCaption == getStatusOfClaim(selectedIndexFilter))
          .toList();
      claimHistoryList.value = motorFilteredData;
    }
    if (decider == "Medical") {
      claimHistoryList.clear();
    } else if (decider == "Motor") {
      totalExistingMedicalClaims.clear();
    }
    // getMotorClaimPolicyList();
    update();
  }

  //return bg color based on status of the plan
  colorByStatus(String statusCaption) {
    switch (statusCaption) {
      case "Renewable":
        return MyColors.renewableBG;
        break;
      case "Active":
        return MyColors.greeen;
        break;
      case "Expired":
        return MyColors.red;
        break;
    }

    MyColors.greeen;
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    lang.value = await _sharedPreferencesHelper.getLang;
    getMotorClaimPolicyList();
    // getMedicalClaims();
  }

  @override
  void onInit() {
    getToken();

    super.onInit();
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
      case 5:
        return "pendingPayment".tr;
        break;
      case 6:
        return "claimRegistered".tr;
        break;
      case 7:
        return "underProcess".tr;
        break;
      default:
        return "draft".tr;
    }
  }

// color status for motor status
  Color getColorByStatus(String decider) {
    switch (decider) {
      case "Draft":
        return MyColors.GrayColor;
        break;
      case "Submitted":
        return MyColors.themeColor;
        break;
      case "Processing":
        return MyColors.themeColor;
        break;
      case "Approved":
        return MyColors.greeen;
        break;
      case "Rejected":
        return MyColors.red;
        break;
      default:
        return MyColors.GrayColor;
    }
  }

// color status for medical status
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

  Future<void> getMedicalClaims() async {
    // Utils.showProgressDialog(Get.context, '', 'Loading...');

    Result result = await DioClient().get('Medical/GetClaims?from=0', token);
    // Get.back();
    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }
      var jsonData = List<MedicalClaimsListModel>.from(
          result.value.map((x) => MedicalClaimsListModel.fromJson(x)));
      totalExistingMedicalClaims.value = jsonData;
      originalExistingMedicalClaims = jsonData;
      selectedFilter.value = "filterBy".tr;
      update();
      getMotorClaimPolicyList();
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }

  //get active policy based on datetime submitted
  void getMotorClaimPolicyList() async {
    var data = {
      "ClaimNumber": null,
      "PolicyNumber": null,
      "StartDateOfLoss": null,
      "EndDateOfLoss": null,
      "ClaimType": null
    };
    Result result = await DioClient().post('MotorClaim/GetClaimList', data,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is SuccessState) {
      claimHistoryList.clear();

      var jsonData = List<ClaimHistory>.from(
          result.value.map((x) => ClaimHistory.fromJson(x)));
      claimHistoryList.value = jsonData;
      totalExisitingMotorPlan = jsonData;

      update();
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.error.toString());
    }
  }
}
