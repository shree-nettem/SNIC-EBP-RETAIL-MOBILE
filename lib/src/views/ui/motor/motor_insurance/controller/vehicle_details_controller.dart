import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/draft_format.dart';
import 'package:ebpv2/src/views/ui/motor/model/make_year.dart';
import 'package:ebpv2/src/views/ui/motor/model/vehicle_make.dart';
import 'package:ebpv2/src/views/ui/motor/model/vehicle_model.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/upload_document_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:intl/intl.dart';
import 'insurance_payment_controller.dart';

class VehicleDetailsXController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dropdownState = GlobalKey<FormFieldState>();

  RxList<bool> isBrandNew = [true, false].obs;
  List<VehicleMake> makeList;
  List<ModelDetail> modelList;
  MotorInsuranceDraftFormat draftFormat;
  List<String> vehicleMakeList = ["SELECT"],
      vehicleModelList = ["SELECT"],
      makeYearList = ["SELECT"],
      faultCalim = [];

  RxString vehicleModel = "SELECT".obs, makeYear = "SELECT".obs;

  String vehicleMake = "SELECT", selectedFaultClaim = "0";

  TextEditingController motorValue, policyStartDate, policyExpiryDate;
  String token;
  final MotorXController motorXController = Get.find();
  final MotorPalnXController planXController = Get.find();
  final UploadDocumentController documentController = Get.find();
  RxString motorSumValue = '0'.obs;

  @override
  void onInit() {
    motorValue = TextEditingController();
    policyStartDate = TextEditingController();
    policyExpiryDate = TextEditingController();
    faultCalim = ["0", "1", "2", "3", "4", "5", "More than 5"];
    policyExpiryDate.text = DateTime.now().toString();
    getToken();
    super.onInit();
  }

  //choose from cash and loan
  updateRadioButton(int index) {
    for (int i = 0; i < isBrandNew.length; i++) {
      isBrandNew[i] = i == index;
    }
    if (isBrandNew[0]) {
      selectedFaultClaim = "0";
    }
    policyStartDate.text = "";
    print(selectedFaultClaim);
    print(isBrandNew);
    update();
  }

  void setMake(String claim) {
    vehicleMake = claim;
    makeYear.value = "SELECT";

    getVehicleModle(
        makeList.firstWhere((element) => element.description == claim).code,
        decider: false);
  }

  void setModel(String val) {
    makeYear.value = "SELECT";
    getMakeYear(
        modelList.firstWhere((element) => element.model == val).modelCode,
        decider: false);
  }

  getVehicleMotorValue() => motorValue.text;

  getPolicyStartDate() => policyStartDate.text;

  @override
  void onClose() {
    motorValue.dispose();
    policyStartDate.dispose();
    super.onClose();
  }

/* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getSavedDraft();
  }

  getSavedDraft() async {
    res.Result result =
        await DioClient().get('Customer/GetPreference/MotorPlan', token);
    if (result is res.SuccessState && result != null) {
      var jsonData = MotorInsuranceDraftFormat.fromJson(result.value);
      if (jsonData is MotorInsuranceDraftFormat) {
        draftFormat = jsonData;

        if (draftFormat.result.isPaymentSuccessful != null &&
            draftFormat.result.isPaymentSuccessful &&
            !draftFormat.result.isPolicyIssued) {
          InsurancePaymentXController insurancePaymentXController =
              Get.put(InsurancePaymentXController());
          insurancePaymentXController.confirmPayment(
              id: draftFormat.result.transactionNumber,
              token: token,
              quote: draftFormat.result.quote);
        } else {
          motorXController.draftProgressStatus.clear();
          motorXController.draftProgressStatus = [
            new MotorInsuranceDraft(
                false,
                draftFormat.result.vehicleDetailsStatus != null
                    ? draftFormat.result.vehicleDetailsStatus
                    : 1),
            new MotorInsuranceDraft(
                false,
                draftFormat.result.selectYourPlanStatus != null
                    ? draftFormat.result.selectYourPlanStatus
                    : 0),
            new MotorInsuranceDraft(
                false,
                draftFormat.result.paymentStatus != null
                    ? draftFormat.result.paymentStatus
                    : 0),
          ];

          if (draftFormat.result.vehicleDetailsStatus == 1 ||
              draftFormat.result.vehicleDetailsStatus == 0) {
            getVehicleMakeList(decider: false);
            motorXController.expansionCardKey[0].currentState.expand();
          } else {
            //vehicle details controller values set
            isBrandNew.clear();
            isBrandNew.value = draftFormat.result.brandNew.obs;
            motorValue.text = draftFormat.result.sumInsured;
            policyStartDate.text = draftFormat.result.policyStartDate;

            planXController.paymentType = draftFormat.result.paymentType != null
                ? draftFormat.result.paymentType
                : [false, false];

            planXController.ownership = draftFormat.result.ownership != null
                ? draftFormat.result.ownership
                : [false, false];

            planXController.isCashFlowVisible =
                draftFormat.result.isCashFlowVisible != null
                    ? draftFormat.result.isCashFlowVisible
                    : false;
            planXController.isPlanSelected =
                draftFormat.result.isPlanSelected != null
                    ? draftFormat.result.isPlanSelected
                    : false;

            planXController.isRecommendedVisible =
                draftFormat.result.isRecommendedVisible != null
                    ? draftFormat.result.isRecommendedVisible
                    : false;

            planXController.isLoanFlowVisible =
                draftFormat.result.isLoanFlowVisible != null
                    ? draftFormat.result.isLoanFlowVisible
                    : false;

            planXController.isCustomerFlowVisible =
                draftFormat.result.isCustomerFlowVisible != null
                    ? draftFormat.result.isCustomerFlowVisible
                    : false;
            planXController.isBankFlowVisible =
                draftFormat.result.isBankFlowVisible != null
                    ? draftFormat.result.isBankFlowVisible
                    : false;

            planXController.isQuotIssued =
                draftFormat.result.isQuotIssued != null
                    ? draftFormat.result.isQuotIssued
                    : false;
            documentController.isDealerQuotionUploaded.value =
                draftFormat.result.isDealerQuotionUploaded != null
                    ? draftFormat.result.isDealerQuotionUploaded
                    : false;
            selectedFaultClaim =
                draftFormat.result.noClaimDeclarationPeriod != null
                    ? draftFormat.result.noClaimDeclarationPeriod
                    : "0";
            planXController.quotationNumer = draftFormat.result.quoteNumber;
            DateTime startDate =
                DateFormat("yyyy-MM-dd").parse(policyStartDate.text);
            DateTime lastDayOfMonth =
                new DateTime(startDate.year + 1, startDate.month + 1, 0);
            policyExpiryDate.text = draftFormat.result.policyExpiryDate != null
                ? draftFormat.result.policyExpiryDate
                : lastDayOfMonth.toString();
            planXController.selectedBankName.value =
                draftFormat.result.bankName != null
                    ? draftFormat.result.bankName
                    : "SELECT";
            getVehicleMakeList(decider: true);
          }
        }
        motorXController.update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  Future<void> getVehicleMakeList({bool decider}) async {
    res.Result result =
        await DioClient().get('Motor/GetVehicleMakeJson', token);
    if (result is res.SuccessState) {
      var jsonData = List<VehicleMake>.from(
          result.value.map((x) => VehicleMake.fromJson(x)));
      if (jsonData is List<VehicleMake>) {
        makeList = jsonData;
        vehicleMakeList.addAll(jsonData.map((e) => e.description).toList());

        if (decider) {
          if (draftFormat.result.motorMake == null ||
              draftFormat.result.motorMake.isEmpty) {
            vehicleMake = "SELECT";
          } else {
            vehicleMake = draftFormat.result.motorMake;
            getVehicleModle(
                makeList
                    .firstWhere((element) => element.description == vehicleMake)
                    .code,
                decider: true);
          }
        } else {
          vehicleMake = "SELECT";
        }

        update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  Future<void> getVehicleModle(String value, {bool decider}) async {
    var requestData = {"makeCode": value};

    res.Result result = await DioClient().post(
        'Motor/GetVehicleModelList', requestData,
        token: token, isPostData: true);
    if (result is res.SuccessState) {
      var jsonData = VehicleModel.fromJson(result.value);
      if (jsonData is VehicleModel) {
        modelList = null;
        modelList = jsonData.vehicleModel[0].modelDetails;

        if (decider) {
          if (draftFormat.result.motorModel == null ||
              draftFormat.result.motorModel.isEmpty) {
            vehicleModelList = [vehicleModel.value];
          } else {
            draftFormat.result.motorModel != null &&
                    draftFormat.result.motorModel.isNotEmpty
                ? vehicleModel.value = draftFormat.result.motorModel
                : vehicleModel.value = "SELECT";
            getMakeYear(
                modelList
                    .firstWhere(
                        (element) => element.model == vehicleModel.value)
                    .modelCode,
                decider: true);
          }
        } else {
          vehicleModelList = [vehicleModel.value];
        }
        vehicleModelList.addAll(modelList.map((e) => e.model).toSet().toList());

        update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  Future<void> getMakeYear(String value, {bool decider}) async {
    res.Result result = await DioClient()
        .get('Motor/GetVehicleYear?vehicleModel=$value', token);
    if (result is res.SuccessState) {
      var jsonData = MakeYear.fromJson(result.value);
      if (jsonData is MakeYear) {
        if (decider) {
          if (draftFormat.result.motorModel == null ||
              draftFormat.result.motorModel.isEmpty) {
            makeYearList = [makeYear.value];
          } else {
            draftFormat.result.year != null &&
                    draftFormat.result.year.isNotEmpty
                ? makeYear.value = draftFormat.result.year
                : makeYear.value = "SELECT";

            if (draftFormat.result.selectYourPlanStatus == 1 ||
                draftFormat.result.selectYourPlanStatus == 2 ||
                draftFormat.result.paymentStatus == 1) {
              planXController.getPlanDetails(
                  paymentMethodCall: false, updateDetails: true);
            }
          }
        } else {
          makeYearList = [makeYear.value];
        }

        makeYearList.addAll(jsonData.years.map((e) => e.toString()).toList());

        update();
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void setFaultClaim(String val) {
    selectedFaultClaim = val;
  }

  void resetPlanDetails() {
    CustomDialogHelper.showCustomDialog(
        title: "Alert",
        description:
            "Editing will reset all existing progress on the motor insurance. "
            "click ok to select a new motor plan, cancel to resume",
        okBtnFunction: () {
          motorXController.draftProgressStatus[0].status = 1;
          motorXController.draftProgressStatus[1].status = 0;
          motorXController.draftProgressStatus[2].status = 0;
          planXController.selectedIndex.value = 0;
          planXController.isCashFlowVisible = false;
          planXController.isQuotIssued = false;
          planXController.isPlanSelected = false;
          planXController.isLoanFlowVisible = false;
          planXController.isCustomerFlowVisible = false;
          planXController.isBankFlowVisible = false;
          documentController.isDealerQuotionUploaded.value = false;
          planXController.quotationNumer = "";
          planXController.eligibleOption.value = "SELECT";
          planXController.selectedBankName.value = "SELECT";
          planXController.paymentType = [false, false];
          motorXController.expansionCardKey[0].currentState.collapse();
          motorXController.expansionCardKey[1].currentState.collapse();
          motorXController.expansionCardKey[2].currentState.collapse();
          planXController.quote = null;
          DateTime startDate;
          if (policyStartDate.text.isNotEmpty) {
            startDate = DateFormat("yyyy-MM-dd").parse(policyStartDate.text);
          } else {
            startDate = DateTime.now();
          }
          DateTime lastDayOfMonth =
              new DateTime(startDate.year + 1, startDate.month + 1, 0);
          policyExpiryDate.text = draftFormat.result.policyExpiryDate != null &&
                  draftFormat.result.policyExpiryDate.isNotEmpty
              ? draftFormat.result.policyExpiryDate
              : Utils.convertDateTimeDisplay(lastDayOfMonth.toString());

          planXController.postDraft(callCalculatePremium: true);
          Get.back();
        },
        cancelBtnFunction: () {
          Get.back();
        });
  }

  void setStartAndEndDate(String text) {
    DateTime startDate = DateFormat("yyyy-MM-dd").parse(policyStartDate.text);

    if (isBrandNew[0]) {
      DateTime lastDayOfMonth =
          new DateTime(startDate.year + 1, startDate.month + 1, 0);
      policyExpiryDate.text = lastDayOfMonth.toString();
    } else if (isBrandNew[1]) {
      DateTime lastDayOfMonth =
          new DateTime(startDate.year + 1, startDate.month, startDate.day);
      policyExpiryDate.text =
          Utils.convertDateTimeDisplay(lastDayOfMonth.toString());
    }
  }

  bool validateSumInsured(String value) {
    if (value == "") return false;
    if (int.parse(value) < 1000) {
      CustomDialogHelper.showAlertDialog(
          title: "Alert",
          description: "Motor value cannot be less then BHD 1000",
          okBtnFunction: () {
            Get.back();
          });
    } else if (int.parse(value) > 50000) {
      CustomDialogHelper.showAlertDialogWithHyperlink(
          title: "Alert",
          okBtnFunction: () {
            Get.back();
          });
    } else {
      if (formKey.currentState.validate()) {
        motorXController.draftProgressStatus[0].status = 2;
        motorXController.draftProgressStatus[1].status = 1;
        planXController.selectedIndex.value = 0;
        planXController.pageNo = 0;
        planXController.postDraft(callCalculatePremium: false);
      }
    }
  }
}
