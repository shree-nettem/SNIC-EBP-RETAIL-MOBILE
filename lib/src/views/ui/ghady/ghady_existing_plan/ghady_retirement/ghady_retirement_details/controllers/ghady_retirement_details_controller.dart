import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/models/ghady_history_model.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/models/ghady_saving_plan_details_model.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/widgets/current_value_history_dropdown_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/widgets/retirement_graph_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../ghady_existing_request_model.dart';

class GhadyRetirementDetailsController extends GetxController {
  GhadyExistingRequestModel ghadyExistingRequestModel;
  List<GhadyHistoryModel> graphHistoryList = [];
  String token;
  List<SalesData> primaryPolicyChartData = [];
  List<SalesData> secondaryContributionChartData = [];
  List<HistoryOverAllModel> historyOverAllModel = [];
  GhadySavingPlanDetailsModel ghadySavingPlanDetails;
  List<AllocationsDistribution> allocationsDistribution = [];
  int selectedCurrentValueHistory = 1;
  num contribution = 0;
  num policyValue = 0;
  int activityCount = 5;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      ghadyExistingRequestModel = Get.arguments["ghady_existing_plan"];
      debugPrint("Arguments" + ghadyExistingRequestModel.frequencyLabel);
    } else {
      debugPrint("Arguments null");
    }

    getDropDownValues();
    fetchGraphHistory();
    fetchGhadyPerformanceOverview();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  // FETCH GRAPH POINTS
  fetchGraphHistory({int dropDownValue = 1, bool keepLoading = true}) async {
    await getToken();
    Result result = await DioClient().get(
        'Performance/getHistory?requestID=${ghadyExistingRequestModel.requestId}&freq=$dropDownValue',
        token,
        keepLoading: keepLoading);
    if (result is SuccessState) {
      primaryPolicyChartData.clear();
      secondaryContributionChartData.clear();
      contribution = 0;
      if (result.value != null) {
        graphHistoryList = (result.value as List)
            .map((data) => GhadyHistoryModel.fromJson(data))
            .toList();
        if (graphHistoryList.isNotEmpty) {
          contribution = graphHistoryList[graphHistoryList.length - 1] != null
              ? graphHistoryList[graphHistoryList.length - 1].premium
              : 0;
        } else {
          errorMessage('noRecordsFound'.tr);
        }
      } else {
        errorMessage('noRecordsFound'.tr);
      }

      updateChart(dropDownValue);
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  updateChart(dropDownValue) {
    for (int i = 0; i < graphHistoryList.length; i++) {
      var date = Utils.getOnlyYear(graphHistoryList[i].date);

      if (dropDownValue == 2) {
        var date = Utils.getOnlyFormattedDate(graphHistoryList[i].date);
        primaryPolicyChartData
          ..add(SalesData(date, graphHistoryList[i].amount));
        secondaryContributionChartData
          ..add(SalesData(date, graphHistoryList[i].premium));
      } else {
        primaryPolicyChartData
          ..add(SalesData(date, graphHistoryList[i].amount));
        secondaryContributionChartData
          ..add(SalesData(date, graphHistoryList[i].premium));
      }

      debugPrint("SECONDARY ${secondaryContributionChartData.length}");
    }

    update();
  }

  //FETCH GHADY PERFORMANCE OVERVIEW
  fetchGhadyPerformanceOverview() async {
    await getToken();
    Result result = await DioClient().get(
      'Performance/getOverview?requestID=${ghadyExistingRequestModel.requestId}',
      token,
      isLoading: false,
    );
    if (result is SuccessState) {
      if (result.value != null) {
        ghadySavingPlanDetails =
            GhadySavingPlanDetailsModel.fromJson(result.value);

        allocationsDistribution =
            ghadySavingPlanDetails.allocationsDistribution;

        var defaultAllocationDate =
            Utils.convertStringDateToDate(allocationsDistribution[0].date);

        for (int i = 0; i < allocationsDistribution.length; i++) {
          var itemDate =
              Utils.convertStringDateToDate(allocationsDistribution[i].date);
          if (itemDate.isBefore(defaultAllocationDate)) {
            defaultAllocationDate = itemDate;
          }
        }

        // SET DEFAULT ASSET VALUES
        for (int i = 0; i < allocationsDistribution.length; i++) {
          var itemDate =
              Utils.convertStringDateToDate(allocationsDistribution[i].date);
          if (itemDate.isAfter(defaultAllocationDate)) {
            allocationsDistribution
                .removeAt(i); // Deleting the newer date element [5]
            i--;
          }
        }
      } else {
        DioClient().hideLoading();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  getDropDownValues() {
    historyOverAllModel..add(HistoryOverAllModel(1, "Overall"));
    historyOverAllModel..add(HistoryOverAllModel(2, "Last 12 Months"));
    historyOverAllModel..add(HistoryOverAllModel(3, "Last 30 Days"));
  }

  updateHistoryValue(int key) {
    selectedCurrentValueHistory = key;
    fetchGraphHistory(
        dropDownValue: selectedCurrentValueHistory, keepLoading: false);
    update();
  }

  //LOAD MORE ACTIVITY
  void loadActivityMore() {
    activityCount += 5;

    if (ghadySavingPlanDetails.activities.length < activityCount - 5) {
      activityCount = 5;
      debugPrint("COUNT VIEW LESS");
    } else {
      debugPrint("COUNT VIEW MORE");
    }

    debugPrint(
        "COUNT $activityCount ${ghadySavingPlanDetails.activities.length}");
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
