import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/startup/country_code_model.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartUpController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: Duration(seconds: (5)),
      vsync: this,
    );
    getCountryCodes();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  getCountryCodes() async {
    Result result =
        await DioClient().get('Values/CountryCodes', '', isLoading: false);
    if (result is SuccessState) {
      var jsonData = CountryCodeModel.fromJson(result.value);
      Constants.baseCountries = jsonData.result.map((e) => e.name).toList();
      Constants.baseCountries.insert(0, "Select");
      Constants.baseCountryCodesFromApi = jsonData.result;
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }
}
