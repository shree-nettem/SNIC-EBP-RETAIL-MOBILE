import 'dart:collection';
import 'dart:convert';

import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/about_us/faq_model.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQController extends GetxController {
  String info = "";
  bool isInfoReceived = false;
  List<FAQModel> faqModel = [];

  LocalizationController localizationController =
      Get.isRegistered<LocalizationController>()
          ? Get.find<LocalizationController>()
          : Get.put(LocalizationController(sharedPreferences: Get.find()));

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInfo("faq");
    });
  }

  fetchInfo(code) async {
    Result result = await DioClient().get(
        'Account/GetInfoPageData?configurationId=$code&locale=${localizationController.locale.languageCode}',
        "");
    if (result is SuccessState) {
      Map<String, dynamic> mapData =
          new Map<String, dynamic>.from(json.decode(result.value["detail"]));
      faqModel = mapData['Data']
          .map((data) => FAQModel.fromJson(data))
          .toList()
          .cast<FAQModel>();

      debugPrint("FAQ LIST ${faqModel.length}");
      isInfoReceived = true;
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
