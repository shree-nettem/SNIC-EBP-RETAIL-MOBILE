import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/group_life/models/get_benificiaries_model.dart';
import 'package:get/get.dart';

class BeneficiaryXController extends GetxController {
  RxBool hideAddBenificiaryScreen = true.obs;

  List<double> totalPercentages = [20, 20, 60];

  List<LifeBenificiaries> totalBenificiaries = [];

  RxBool isSaveOn = false.obs;
  String token;
// used to show error msg when user cliked save button
  RxBool hidePercentageText = true.obs;

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
    getBeificiaries();
  }

  changeBenificiaryUI() {
    hideAddBenificiaryScreen.toggle();
    update();
  }

  openAlertDialog(String message) {
    Utils.showAlertDialogHelp(Get.context, message, "Ok");
    update();
  }

  shareEqualPercetages() {
    totalBenificiaries = totalBenificiaries.map<LifeBenificiaries>((element) {
      element.beneficiaryPercentage =
              // double.parse(
              (100.0 / totalBenificiaries.length)
          // .toStringAsFixed(1))
          ;
      return element;
    }).toList();
    isSaveOn.value = true;
    update();
  }

  bool checkTotalPercentageIsequal100() {
    if (totalBenificiaries.length == 0) {
      return true;
    }
    double finalPercenntage = 0.0;
    totalBenificiaries.forEach((element) {
      finalPercenntage += element.beneficiaryPercentage;
    });
    togglePercentageText(true);
    return finalPercenntage.toInt() == 100 ? true : false;
  }

  void togglePercentageText(bool boolValue) {
    hidePercentageText.value = boolValue;
    // update();
  }

  double getCurrentPercentage() {
    double finalPercenntage = 0.0;
    totalBenificiaries.forEach((element) {
      finalPercenntage +=
          // double.parse(
          (element.beneficiaryPercentage);
      // .toStringAsFixed(1));
    });
    togglePercentageText(true);
    return finalPercenntage.floorToDouble();
  }

  getBeificiaries() async {
    Result result =
        await DioClient().get('Life/GetBeneficiaries', token, isLoading: false);
    if (result is SuccessState) {
      var jsonData = List<LifeBenificiaries>.from(
          result.value.map((x) => LifeBenificiaries.fromJson(x)));
      if (jsonData is List<LifeBenificiaries>) {
        totalBenificiaries = jsonData;
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      // errorMessage(result.msg.error.toString());
    }
  }

  saveBenificiaries() async {
    var requestMap =
        List<dynamic>.from(totalBenificiaries.map((x) => x.toJson()));
    print(requestMap.length);
    Result result = await DioClient().post('Life/SaveBeneficiaries', requestMap,
        token: token, isPostData: true, isHeaderJsonType: true);
    // Get.back();

    if (result is SuccessState) {
      getBeificiaries();
      successMessage("records_saved".tr);
      isSaveOn.value = false;
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }
}
