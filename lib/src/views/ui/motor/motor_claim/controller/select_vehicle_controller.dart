import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/model/policy_details.dart';
import 'package:ebpv2/src/views/ui/motor/model/sunmi_claim_policy_list.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'motor_claim_controller.dart';

class SelectVehicleXController extends GetxController {
  final List<GlobalKey<ExpansionTileCardState>> expansionCardKey = [
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
  ];
  final formFieldKey = GlobalKey<FormState>();
  TextEditingController accidentDateController, selectedTime;
  List<String> sourceOfIncomeOptions;
  bool isNextButtonClicked,
      isClaimDetailSubmitted,
      isAnActivePlanSelected,
      isUploadDocumentVisible;
  String token;
  PolicySearch selectedPolicy;
  MotorClaimXController controller = Get.find();
  ClaimPolicyList policyList;
  PolicyDetails policyDetails;
  String selectedAccidentDate, selectedAccidentTime;

  @override
  void onInit() {
    isNextButtonClicked = false;
    isAnActivePlanSelected = false;
    isClaimDetailSubmitted = false;
    isUploadDocumentVisible = false;
    accidentDateController = TextEditingController();
    selectedTime = TextEditingController();
    sourceOfIncomeOptions = ["Select", "Salaried", "SelfEmployed"];
    getToken();
    super.onInit();
  }

  void onNextButtonClicked() {
    var parsedDate =
        DateTime.parse('$selectedAccidentDate $selectedAccidentTime');

    if (parsedDate.isBefore(DateTime.parse(convertDateTimeDisplay()))) {
      getClaimPolicyList(selectedAccidentDate, selectedAccidentTime);
    } else {
      errorMessage("Accident Time cannot be greater than now");
    }
  }

  String convertDateTimeDisplay() {
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd HH:mm');
    final String formatted = serverFormater.format(DateTime.now());
    return formatted;
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
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

  @override
  void onClose() {
    // TODO: implement onClose
    accidentDateController.dispose();
    selectedTime.dispose();
    super.onClose();
  }

  void activePlanSelected(PolicySearch selectedPolicy) {
    this.selectedPolicy = selectedPolicy;

    getPolicyDetails(selectedPolicy);
  }

  //get active policy based on datetime submitted
  void getClaimPolicyList(String date, String time) async {
    // MotorClaimDetailsXController controller = Get.find();
    MotorClaimXController _controller = Get.find();
    var parsedDate = DateTime.parse('$date $time');

    Result result = await DioClient()
        .get('Motor/GetClaimPolicyList?accidentDateTime=$parsedDate', token);
    if (result is SuccessState) {
      policyList = ClaimPolicyList.fromJson(result.value);

      if (policyList.policySearch.length > 0) {
        isNextButtonClicked = true;
        update();
        // controller.getGarageDealerShip();
        _controller.update();
      } else {
        errorMessage("No plans are available at this time");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  Future<void> getPolicyDetails(PolicySearch selectedPolicy) async {
    var body = {"policyNumber": selectedPolicy.policyNumber};
    MotorClaimDetailsXController motorXController = Get.find();
    Result result = await DioClient()
        .post('Motor/GetPolicyDetails', body, token: token, isPostData: true);
    if (result is SuccessState) {
      policyDetails = PolicyDetails.fromJson(result.value);
      motorXController.getGarageDealerShip(policyDetails.quotationNumber);
      isAnActivePlanSelected = true;
      expansionCardKey[0].currentState.collapse();
      Get.find<MotorClaimDetailsXController>().getAccidentLocations();
      controller.update();
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }
}
