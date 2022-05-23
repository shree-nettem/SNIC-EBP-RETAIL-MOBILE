import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalEcardXController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
