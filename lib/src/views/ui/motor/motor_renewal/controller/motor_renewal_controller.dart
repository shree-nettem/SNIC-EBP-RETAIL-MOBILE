import 'dart:convert';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculating_premium_renewal_flow.dart';
import 'package:ebpv2/src/views/ui/motor/model/personal_verification.dart';
import 'package:ebpv2/src/views/ui/motor/model/renew_plan_details.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/contact_deatils_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/renew_switch_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/screen/motor_renewal_detailed_plan.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/screen/review_policy.dart';
import 'package:ebpv2/src/views/ui/plan/model/plan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumio_mobile_sdk_flutter/jumio_mobile_sdk_flutter.dart';

import '../../../../../utilities/credentials.dart';
import '../../../../base/custom_dialog_helper.dart';
import '../../../auth/verification/verification_response_model.dart';

class MotorRenewalXController extends GetxController {
  final formKey = GlobalKey<FormState>();

  RxList<PolicySearch> totalExisitingMotorPlan;
  bool isReleaseLetterSelected,
      isReleaseletterViewVisibile,
      isPlanViewVisible,
      isPaymentViewVisible;
  bool isRecommendedVisible,
      isSwitchFlowselected,
      isSupplementaryBenifitsVisible,
      isPolicyfees,
      isVatVisible,
      isDiscountVisilbe;
  List<String> eligibleUpgradeList = ["SELECT"];

  TextEditingController plateNumber;
  RxString eligibleOption = "SELECT".obs, selectedBankName = 'SELECT'.obs;
  RenewPlanDetails planDetails;
  RenewSwitchController controller = Get.put(RenewSwitchController());

//total premium variables
  RxDouble total = 0.0.obs,
      supplimentBenifitTotal = 0.0.obs,
      vat = 0.0.obs,
      policyFees = 0.0.obs;
  String token, customerName;
  RenewPlanDetails detail;
  CalculatingPremium premium;
  PlansModel model;
  PersonalVerification verification;
  String userId;

  @override
  void onInit() {
    isSupplementaryBenifitsVisible = true;
    isPolicyfees = true;
    isVatVisible = true;
    isDiscountVisilbe = true;
    totalExisitingMotorPlan = RxList<PolicySearch>();
    plateNumber = TextEditingController();
    isPlanViewVisible = false;
    isPaymentViewVisible = false;
    isReleaseLetterSelected = false;
    isReleaseletterViewVisibile = false;
    isRecommendedVisible = false;
    isSwitchFlowselected = false;
    getToken();

    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    userId = await _sharedPreferencesHelper.getCustomerId;
    getUserIdentificationStatus();
    getRenewablePlans();
  }

  void getUserIdentificationStatus() async {
    //ToDo need to be changed
    Result result =
        await DioClient().get('Customer/PersonalVerification', token);

    if (result is SuccessState) {
      //  var json = myTransformer.toGData();
      verification = PersonalVerification.fromJson(result.value);
    }
  }

/*
  void updateItemStatus(item) {
    totalExisitingMotorPlan[item].isexpanded
        ? totalExisitingMotorPlan[item].isexpanded = false
        : totalExisitingMotorPlan[item].isexpanded = true;

    update();
  }
*/

  //set flow control variables
  void updateNxtButtonClick() {
    if (isPlanViewVisible &&
        !isReleaseletterViewVisibile &&
        !verification.personalVerification) {
      calculateTotalPremeium();
      isPaymentViewVisible = false;
      isPlanViewVisible = false;
      isReleaseletterViewVisibile = true;
    } else if (isPlanViewVisible &&
        !isReleaseletterViewVisibile &&
        verification.personalVerification) {
      calculateTotalPremeium();
      isPaymentViewVisible = true;
      isPlanViewVisible = false;
      isReleaseletterViewVisibile = false;
      isPaymentViewVisible = true;
    } else if (!isPlanViewVisible && isReleaseletterViewVisibile) {
      isPaymentViewVisible = true;
      isPlanViewVisible = false;
      isReleaseletterViewVisibile = false;
      RenewSwitchController switchController = Get.find();
      switchController.getCalculatingPremium(
          policyIDate: detail.policyInceptionDate,
          quotationNumber: detail.quotationNumber,
          policySi: detail.policySumInsured);
    }
    controller.update();
  }

  onBackPressed() {
    if (!isPlanViewVisible && isReleaseletterViewVisibile) {
      if (isSwitchFlowselected) {
        isReleaseletterViewVisibile = false;
        isPlanViewVisible = true;
      } else {
        Get.back();
      }
    } else if (isPaymentViewVisible && isReleaseletterViewVisibile) {
      isPlanViewVisible = false;
      isReleaseletterViewVisibile = true;
    } else {
      Get.back();
    }

    update();
  }

  //add suppliment benifits to the plan
  switchSupplimentBenifits(index) {
    for (int i = 0; i < premium.optionalCovers.length; i++) {
      if (index == i && premium.optionalCovers[i].isSelected) {
        premium.optionalCovers[i].isSelected = false;
      } else if (index == i && !premium.optionalCovers[i].isSelected) {
        premium.optionalCovers[i].isSelected = true;
      }
    }
    calculateTotalPremeium();
    update();
  }

  //show or hide release letter view
  toggleRelaseLetter() {
    isReleaseLetterSelected
        ? isReleaseLetterSelected = false
        : isReleaseLetterSelected = true;
    controller.update();
  }

  @override
  void onClose() {
    plateNumber.dispose();
    super.onClose();
  }

/*  void showReleaseLetterView() {
    isReleaseletterViewVisibile = true;
    update();
  }*/

  //get all plans for renewal
  void getRenewablePlans() async {
    Result result = await DioClient().get(
        'Motor/GetPolicyList?policyStatus=12&fromDate=&toDate=&maximumRowNumber=',
        token);
    if (result is SuccessState) {
      model = PlansModel.fromJson(result.value);

      totalExisitingMotorPlan.addAll(model.policySearch);
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  // get user selected plan details
  void getRenewablePlanDetails(
      String quotationNumber,
      String policyIDate,
      String modelGroup,
      String vehicleMake,
      String policySi,
      String policyPartyName) async {
    Result result = await DioClient().get(
        '/Motor/GetPreviousPlanDetails?quotationNumber=$quotationNumber',
        token);
    if (result is SuccessState) {
      detail = RenewPlanDetails.fromJson(result.value);
      planDetails = detail;
      customerName = policyPartyName;
      Get.to(MotorRenewalDeatiledPlanScreen(quotationNumber, policyIDate,
          modelGroup, vehicleMake, detail, policySi));
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  //calculation of supplimentary benifits of corresponding plans
  String calculateSupplementaryBenifitsTotal() {
    supplimentBenifitTotal.value = 0.0;
    if (detail != null) {
      premium.optionalCovers.forEach((element) {
        supplimentBenifitTotal.value = element.isSelected
            ? element.price + supplimentBenifitTotal.value
            : supplimentBenifitTotal.value + 0.0;
      });
    }
    if (eligibleOption.value != "SELECT") {
      supplimentBenifitTotal.value += premium.eligibleUpgrades
          .where((e) => e.label == eligibleOption.value)
          .first
          .price;
    }

    return supplimentBenifitTotal.toString();
  }

  //calculate total premium
  String calculateTotalPremeium() {
    //upadte policy fees later

    total.value = 0.0;
    policyFees.value = 0.0;
    vat.value = 0.0;

    var suplimentaryBenifitTotal =
        double.parse(calculateSupplementaryBenifitsTotal());
    policyFees.value = double.parse(premium.policyFees);
    vat.value += (((suplimentaryBenifitTotal +
                double.parse(premium.strBasicPremium) +
                policyFees.value) *
            10) /
        100);

    total.value = (suplimentaryBenifitTotal +
        policyFees.value +
        vat.value +
        double.parse(premium.strBasicPremium));

    return total.value.toStringAsFixed(3);
  }

  //calculating premium if user did not opt for switch plan
  Future<void> getCalculatingPremium(
      {String policyIDate,
      String quotationNumber,
      String modelGroup,
      String vehicleMake,
      bool updatePremium = false,
      String policySi}) async {
    var data = {
      "PolicyStartDate": policyIDate,
      "SumInsured": policySi,
      "QuoteNumber": quotationNumber,
      "CarReplacement": updatePremium && eligibleOption.value != 'SELECT'
          ? premium.eligibleUpgrades
              .where((element) => element.label == eligibleOption.value)
              .first
              .value
          : "",
      "PlanName": detail.planName,
      "BankName": null,
      "PlateNumber": detail.registrationNo,
      "Mortgage": detail.isMortgage,
    };
    final MotorRenewalXController motorController = Get.find();
    if (premium != null) {
      premium.optionalCovers.forEach((element) =>
          data.putIfAbsent(element.value, () => element.isSelected.toString()));
    }
    Result result = await DioClient().post('/Motor/CalculatingPremium', data,
        token: token, isPostData: true);
    if (result is SuccessState) {
      if (!updatePremium) {
        premium = CalculatingPremium.fromJson(result.value);

        if (eligibleUpgradeList.length == 1) {
          eligibleOption.value = "SELECT";
          eligibleUpgradeList = [eligibleOption.value];
          eligibleUpgradeList
              .addAll(premium.eligibleUpgrades.map((e) => e.label));

          try {
            var val = eligibleUpgradeList.firstWhere((element) {
              if (element.toLowerCase().contains(
                      motorController.planDetails.carReplace.toLowerCase()) &&
                  element.contains(motorController.planDetails.carReplaceDays))
                return true;
              return false;
            });
            eligibleOption.value = val;
          } catch (e) {
            print(e);
            eligibleOption.value = "SELECT";
          }
        }

        calculateTotalPremeium();

        Get.to(ReviewPolicy(policyIDate, quotationNumber, premium, policySi));
      } else {
        isPaymentViewVisible = false;
        isReleaseletterViewVisibile = true;
        controller.issueQuote(quotationNumber);
        if (verification.personalVerification) {
          updateNxtButtonClick();
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  void initializeJumio() {
    debugPrint("USER ID $userId");
    _startNetverify();
  }

  Future<void> _startNetverify() async {
    String callBackURL =
        "https://jumio.snic.com.bh/Onboarding/SetIdentityVerification?id=$userId&referralCode=";
    await _logErrors(() async {
      await JumioMobileSDK.initNetverify(API_TOKEN, API_SECRET, DATACENTER, {
        "enableVerification": true,
        "callbackUrl": callBackURL,
        "enableIdentityVerification": true,
        "preselectedCountry": "BHR",
        "reportingCriteria": "NewCustomerOnboarding",
        "customerInternalReference": userId.toString(),
        "userReference": userId.toString(),
        "sendDebugInfoToJumio": true,
        "cameraPosition": "back",
        "documentTypes": ["IDENTITY_CARD"],
        "enableWatchlistScreening": ["enabled"],
        "watchlistSearchProfile": "afbb950f-b540-407c-9a3e-9815816ca91b",
      });
      final result = await JumioMobileSDK.startNetverify();
      if (Utils.getJumioErrorMessage(result['errorCode']).isEmpty) {
        getVerificationResponse();
      } else {
        String message = Utils.getJumioErrorMessage(result['errorCode']);
        errorMessage(message);
      }

      debugPrint("JUMIO RESULT $result");
    });
  }

  Future<void> _logErrors(Future<void> Function() block) async {
    try {
      await block();
    } catch (error) {
      await _showDialogWithMessage(error.toString(), "Error");
    }
  }

  Future<void> _showDialogWithMessage(String message,
      [String title = "Result"]) async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: Text(message)),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /* HIT SET IDENTITY VERIFICATION API */
  Future getVerificationResponse() async {
    showLoading();
    update();
    if (Utils.isInternetConnected() != null) {
      Result result = await DioClient().get(
          'Onboarding/GetVerificationResponse?id=$userId', "",
          isLoading: false);
      if (result is SuccessState) {
        var jsonData = VerificationResponseModel.fromJson(result.value);

        final body = json.decode(jsonData.jumioResponse);
        String jumioVerificationStatus = body['verificationStatus'];

        if (jumioVerificationStatus == "APPROVED_VERIFIED") {
          if (jsonData is VerificationResponseModel &&
              jsonData.benefitResponse != null) {
            final body = json.decode(jsonData.benefitResponse);

            final messageStatus = body["messageStatus"];
            var amlResponse;
            if (body != null && messageStatus == "OK") {
              var jumioAMLResponse;
              if (jsonData.jumioAMLResponse != null) {
                jumioAMLResponse = json.decode(jsonData.jumioAMLResponse);
                debugPrint(
                    "MESSAGE_STATUS ${jumioAMLResponse["document"]["status"]}");
                amlResponse = jumioAMLResponse["document"]["status"];
              }
              if (amlResponse == "APPROVED_VERIFIED") {
                setExistedProfileAndUser(body);
              } else {
                hideLoading();
                errorMessage("Kindly contact the Administrator");
                update();
              }
            } else {
              hideLoading();
              update();
              errorMessage("No records found from Benefits");
            }
          } else {
            // CALL SAME API, IF IT IS NULL
            getVerificationResponse();
          }
        } else {
          hideLoading();
          update();
          errorMessage("Identity verification has failed. Kindly try again");
        }
      } else if (result is ErrorState) {
        hideLoading();
        update();
        errorMessage(result.msg.toString());
      }
    } else {
      hideLoading();
      update();
      errorMessage("Please connect to the network");
    }
  }

  showLoading(
      {bool showLongWaitingMessage = false,
      String tittle = "",
      String description = ""}) {
    CustomDialogHelper.showLoading(
        showLongWaitingMessage: showLongWaitingMessage,
        description: description);
  }

  hideLoading() {
    CustomDialogHelper.hideLoading();
  }

  /* POST THE DATA TO SERVER TO SET THE PROFILE (EXISTING USER) */
  void setExistedProfileAndUser(benefitResponseBody) async {
    String firstName = benefitResponseBody["IGAFeilds"]["firstNameEn"] ?? " ";
    String middleName =
        benefitResponseBody["IGAFeilds"]["middleName1En"] ?? " ";
    String lastName = benefitResponseBody["IGAFeilds"]["lastNameEn"] ?? " ";
    String gender = benefitResponseBody["IGAFeilds"]["gender"] ?? " ";
    String dateOfBirth = benefitResponseBody["IGAFeilds"]["dateOfBirth"] ?? " ";
    String telephoneNumber =
        benefitResponseBody["IGAFeilds"]["telephoneNumber"] ?? " ";
    String email = benefitResponseBody["IGAFeilds"]["email"] ?? " ";
    String addressType = benefitResponseBody["IGAFeilds"]["addressType"] ?? " ";
    String placeOfBirth =
        benefitResponseBody["IGAFeilds"]["placeOfBirth"] ?? " ";
    String nationality = benefitResponseBody["IGAFeilds"]["nationality"] ?? " ";
    String passportNumber =
        benefitResponseBody["IGAFeilds"]["passportNumber"] ?? " ";
    String idNumber = benefitResponseBody["IGAFeilds"]["idNumber"] ?? " ";
    int flatNumber = benefitResponseBody["IGAFeilds"]["flatNumber"] ?? " ";
    int buildingNumber =
        benefitResponseBody["IGAFeilds"]["buildingNumber"] ?? " ";
    String buildingAlpha = benefitResponseBody["IGAFeilds"]["buildingAlpha"];
    int roadNumber = benefitResponseBody["IGAFeilds"]["roadNumber"] ?? " ";
    int blockNumber = benefitResponseBody["IGAFeilds"]["blockNumber"] ?? " ";
    String occupation = benefitResponseBody["IGAFeilds"]["occupation"];
    String employeeName = benefitResponseBody["IGAFeilds"]["nameOfEmployer"];
    // String employeeAddress = benefitResponseBody["IGAFeilds"]["occupation"];

    var setExistProfileRequest = {
      "SavingWithGhady": "",
      "GeneralInsurance": "",
      "ViewingMedicalBenefits": "",
      "MailingAddressTown": "",
      "MailingAddressBlock": "",
      "MailingAddressRoad": "",
      "MailingAddressHouse": "",
      "MailingAddressFlat": "",
      "MailingAddressAlpha": "",
      "HomeAddressTown": "",
      "HomeAddressBlock": "",
      "HomeAddressRoad": "",
      "HomeAddressHouse": "",
      "HomeAddressFlat": "",
      "HomeAddressAlpha": "",
      "SourceOfIncome": "",
      "MonthlyIncome": ""
    };

    Result result = await DioClient().post(
        'Onboarding/SetExistedProfileAndUser?id=$userId',
        setExistProfileRequest,
        isPostData: true,
        isLoading: false);
    if (result is SuccessState) {
      Get.back();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  //decide scenario based on difference in make year
  bool ifYearDiffernceGreaterThen2() {
    var makeyear = int.parse(detail.vehicleMake);
    var currentYear = DateTime.now().year;
    return ((currentYear - makeyear) + 0.5) > 2 ? true : false;
  }
}

//draft dummy model do not delete
class DummyModel {
  int index;
  bool isexpanded;

  DummyModel({this.index, this.isexpanded});

  DummyModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    isexpanded = json['isexpanded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['isexpanded'] = this.isexpanded;
    return data;
  }
}
