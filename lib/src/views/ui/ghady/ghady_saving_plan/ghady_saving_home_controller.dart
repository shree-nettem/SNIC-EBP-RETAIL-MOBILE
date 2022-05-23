import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GhadySavingHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);

    if (Get.arguments != null) {
      tabController.animateTo(1);
    }
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
