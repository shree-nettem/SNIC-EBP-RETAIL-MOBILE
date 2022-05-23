import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/dio_client.dart';
import '../../../../../utilities/shared_preference.dart';
import '../../../../../utilities/ui_constants.dart';

class MotorClaimXController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController tabController;
  List<String> uploadingDocumentPath = [];
  int currentFlow;
  String token;
  int surveyDays = 0;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    isPoliceReportSelected = false;
    isMinorMotorClaimSelected = false;
    isCarWindScreenSelected = false;
    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;

    getSurveyDays();
  }

  bool isPoliceReportSelected,
      isMinorMotorClaimSelected,
      isCarWindScreenSelected;

  void flowControl(int flow) {
    currentFlow = flow;
    if (flow == 1) {
      isPoliceReportSelected = true;
      isMinorMotorClaimSelected = false;
      isCarWindScreenSelected = false;
      uploadingDocumentPath = [];
    } else if (flow == 2) {
      isMinorMotorClaimSelected = true;
      isPoliceReportSelected = false;
      isCarWindScreenSelected = false;
      uploadingDocumentPath = [];
    } else if (flow == 3) {
      isCarWindScreenSelected = true;
      isMinorMotorClaimSelected = false;
      isPoliceReportSelected = false;
      uploadingDocumentPath = [];
    }

    update();
  }

  void getSurveyDays() async {
    Result result = await DioClient().get(
      'Values/GetSurveyDays',
      "",
      isLoading: false,
    );

    if (result is SuccessState) {
      surveyDays = result.value["NumberOfDays"];
      update();
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  onBackPressed() {
    SelectVehicleXController vehicleDetailsXController = Get.find();
    if (isPoliceReportSelected) {
      if (vehicleDetailsXController.isNextButtonClicked) {
        vehicleDetailsXController.isNextButtonClicked = false;
        vehicleDetailsXController.isAnActivePlanSelected = false;
        vehicleDetailsXController.isClaimDetailSubmitted = false;
      } else {
        isPoliceReportSelected = false;
      }
      update();
    } else if (isCarWindScreenSelected) {
      if (vehicleDetailsXController.isNextButtonClicked) {
        vehicleDetailsXController.isNextButtonClicked = false;
        vehicleDetailsXController.isAnActivePlanSelected = false;
        vehicleDetailsXController.isClaimDetailSubmitted = false;
      } else {
        isCarWindScreenSelected = false;
      }
      update();
    } else if (isMinorMotorClaimSelected) {
      isMinorMotorClaimSelected = false;
      vehicleDetailsXController.isNextButtonClicked = false;
      vehicleDetailsXController.isAnActivePlanSelected = false;
      vehicleDetailsXController.isClaimDetailSubmitted = false;
      update();
    } else {
      Get.back();
    }
    onStartButtonClicked(position: 0);
  }

  void onStartButtonClicked({int position}) {
    SelectVehicleXController vehicleDetailsXController = Get.find();
    MotorClaimXController _controller = Get.find();
    for (int i = 0;
        i < vehicleDetailsXController.expansionCardKey.length;
        i++) {
      if (position == i &&
          vehicleDetailsXController.expansionCardKey[position].currentState !=
              null) {
        vehicleDetailsXController.expansionCardKey[position].currentState
            .expand();
      } else if (vehicleDetailsXController.expansionCardKey[i] != null &&
          vehicleDetailsXController.expansionCardKey[i].currentState != null) {
        vehicleDetailsXController.expansionCardKey[i].currentState.collapse();
      }
    }
    _controller.update();
  }
}
