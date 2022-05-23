import 'dart:convert';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/download_document.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/image_view.dart';
import 'package:ebpv2/src/views/ui/plan/model/plan_model.dart';
import 'package:ebpv2/src/views/ui/plan/model/policy_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ghady/ghady_existing_plan/ghady_existing_request_model.dart';

class PlanXController extends GetxController {
  RxList<PolicySearch> totalExisitingMotorPlan;
  RxList<PolicySearch> filteredList;

  bool isFilterOptionVisible;
  List<String> productOptions, statusOptions;
  String token;
  RxString selectedProduct = 'All'.obs;
  RxString selectedStatus = 'All'.obs;
  PolicyDetails detail;
  bool isLoading;
  SharedPreferences sharedPreferences;
  bool isArabic = false;
  RxList<GhadyExistingRequestModel> ghadyRequestList;
  RxList<GhadyExistingRequestModel> filteredghadyRequestList;

  @override
  void onInit() {
    isLoading = false;
    totalExisitingMotorPlan = RxList<PolicySearch>();
    filteredList = RxList<PolicySearch>();
    ghadyRequestList = RxList<GhadyExistingRequestModel>();
    filteredghadyRequestList = RxList<GhadyExistingRequestModel>();
    getToken();
    isFilterOptionVisible = false;

    productOptions = [
      "All",
      "Ghady Saving",
      "Motor Insurance",
    ];
    statusOptions = ['All'];
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    update();
    getAllPlans();
  }

  //hide or show filer options
  void showFilterOptions() {
    isFilterOptionVisible
        ? isFilterOptionVisible = false
        : isFilterOptionVisible = true;

    if (isFilterOptionVisible) {
      setProductOnFilter(selectedStatus.value);
    }

    update();
  }

  void getAllPlans() async {
    isLoading = true;
    Result result = await DioClient().get(
        'Motor/GetPolicyList?policyStatus=05&fromDate=&toDate=&maximumRowNumber=',
        token);
    if (result is SuccessState) {
      isLoading = false;
      PlansModel model = PlansModel.fromJson(result.value);

      totalExisitingMotorPlan.addAll(model.policySearch);
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  void getPlanDetails(String policyNumber) async {
    var data = {
      "policyNumber": policyNumber,
    };

    Result result = await DioClient()
        .post('Motor/GetPolicyDetails', data, token: token, isPostData: true);
    if (result is SuccessState) {
      detail = PolicyDetails.fromJson(result.value);

      Get.toNamed(AppRoutes.PLAN_DETAILS);
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  fetchGhadyRequest() async {
    ghadyRequestList.clear();
    Result result =
        await DioClient().get('Saving/GetRequests', token, isLoading: false);
    if (result is SuccessState) {
      ghadyRequestList.value = (result.value as List)
          .map((data) => GhadyExistingRequestModel.fromJson(data))
          .toList();
      filteredghadyRequestList.value = (result.value as List)
          .map((data) => GhadyExistingRequestModel.fromJson(data))
          .toList();
      debugPrint("GHADY_REQUEST_LIST ${ghadyRequestList.length}");
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
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

  void downloadImage(
    PolicyDetails detail,
    Document item,
    bool isViewSelected,
  ) async {
    var details = {
      "level": "POLICY",
      "policyNumber": detail.quotationNumber,
      "documentFileName": item.documentName,
      "documentType": item.documentType
    };
    Result result = await DioClient().post('Motor/DownloadDocument', details,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is SuccessState) {
      DownloadDocumentModel res = DownloadDocumentModel.fromJson(result.value);
      if (isViewSelected && item.documentName.contains(".jpg")) {
        Image img = imageFromBase64String(res.buffer);
        Get.to(ImagePreview(img));
      } else if (isViewSelected) {
        Utils.saveFileFromString(res.buffer, isViewSelected, item.documentType);
      } else if (!isViewSelected) {
        Utils.saveFileFromString(res.buffer, isViewSelected, item.documentType);
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

  void downloadAllDocuments(PolicyDetails detail, int i) async {
    if (detail.documents.length > i) {
      var details = {
        "level": "POLICY",
        "policyNumber": detail.quotationNumber,
        "documentFileName": detail.documents[i].documentName,
        "documentType": detail.documents[i].documentType
      };

      Result result = await DioClient().post('Motor/DownloadDocument', details,
          token: token, isPostData: true, isHeaderJsonType: true);
      if (result is SuccessState) {
        DownloadDocumentModel res =
            DownloadDocumentModel.fromJson(result.value);
        Utils.saveALLRecords(res.buffer, i, detail.documents[i].documentType);

        downloadAllDocuments(detail, i + 1);
        if (detail.documents.length == i) {
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

  void setProductOnFilter(String val) {
    if (val == 'Ghady Saving') {
      statusOptions = [
        'All',
        'Draft',
        'Submitted',
        'Processing',
        'Active',
        'Rejected',
        'Approved'
      ];
      filteredList.clear();
      filteredghadyRequestList.clear();
      // filteredList.value = totalExisitingMotorPlan
      //     .where((val) => val.productName.contains('Ghady'))
      //     .toList();
      //* Call Ghady API and display the data in a view
      fetchGhadyRequest();
    } else if (val == 'Motor Insurance') {
      statusOptions = ['All', 'Active', 'Renewable', 'Expired'];
      filteredList.clear();
      filteredList.value = totalExisitingMotorPlan
          .where((val) => val.productName.contains('Motor'))
          .toList();
    } else if (val == 'All') {
      statusOptions = ['All'];
      filteredList.value.clear();
      filteredList.value = totalExisitingMotorPlan
          .where((val) =>
              val.productName.contains('Motor') ||
              val.productName.contains('Ghady'))
          .toList();
    }

    update();
  }

  void filterByStatus(String val) {
    if (selectedProduct == 'Motor Insurance') {
      filteredList.clear();
      if (val.contains('All')) {
        filteredList.value = totalExisitingMotorPlan
            .where((val) => val.productName.contains('Motor'))
            .toList();
      } else if (val.contains('Active')) {
        filteredList.value = totalExisitingMotorPlan
            .where((val) =>
                val.productName.contains('Motor') &&
                val.statusCaption == 'Active')
            .toList();
      } else if (val.contains('Renewable')) {
        filteredList.value = totalExisitingMotorPlan
            .where((val) =>
                val.productName.contains('Motor') &&
                val.statusCaption == 'Renewable')
            .toList();
      } else if (val.contains('Expired')) {
        filteredList.value = totalExisitingMotorPlan
            .where((val) =>
                val.productName.contains('Motor') &&
                val.statusCaption == 'Expired')
            .toList();
      }
    } else if (selectedProduct == 'Ghady Saving') {
      filteredghadyRequestList.clear();

      //     int goal;
      // int term;
      // num strategy;
      // String frequencyLabel;
      // num frequencyAmount;
      // num lumpsum;
      // int requestId;

      if (val.contains('All')) {
        filteredghadyRequestList.value = ghadyRequestList;
      } else if (val.contains('Draft')) {
        filteredghadyRequestList.value =
            ghadyRequestList.where((val) => val.status == 'Draft').toList();
      } else if (val.contains('Submitted')) {
        filteredghadyRequestList.value =
            ghadyRequestList.where((val) => val.status == 'Submitted').toList();
      } else if (val.contains('Processing')) {
        filteredghadyRequestList.value = ghadyRequestList
            .where((val) => val.status == 'Processing')
            .toList();
      } else if (val.contains('Active')) {
        filteredghadyRequestList.value =
            ghadyRequestList.where((val) => val.status == 'Active').toList();
      } else if (val.contains('Rejected')) {
        filteredghadyRequestList.value =
            ghadyRequestList.where((val) => val.status == 'Rejected').toList();
      } else if (val.contains('Approved')) {
        filteredghadyRequestList.value =
            ghadyRequestList.where((val) => val.status == 'Approved').toList();
      }
    }
    update();
  }

  bool findIfAnyPlanIsRenewable() {
    if (!isFilterOptionVisible) {
      if (totalExisitingMotorPlan
              .where((val) => val.statusCaption == 'Renewable')
              .toList()
              .length >
          0) {
        return true;
      } else {
        return false;
      }
    } else if (isFilterOptionVisible) {
      if (filteredList
              .where((val) => val.statusCaption == 'Renewable')
              .toList()
              .length >
          0) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  String calculateRemainingDays(PolicySearch item) {
    //DateTime parsedDate =DateTime.parse(item.policyIDate) ;

    int date = int.parse(item.policyExpiryDate.split('/').first);
    int month = int.parse(item.policyExpiryDate.split('/').toList()[1]);
    int year = int.parse(item.policyExpiryDate.split('/').last);
    ;
    /* final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(parsedDate);*/
    var resultDays =
        '${DateTime(year, month, date).difference(DateTime.now()).inDays}';
    if (item.statusCaption != null && item.statusCaption.isNotEmpty) {
      return item.statusCaption == 'Renewable'
          ? 'Within $resultDays days'
          : item.statusCaption == 'Renewed'
              ? 'Activates on $resultDays'
              : '';
    } else {
      return '';
    }
  }
}
