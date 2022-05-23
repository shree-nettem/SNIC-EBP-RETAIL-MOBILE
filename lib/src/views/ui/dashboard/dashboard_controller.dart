import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardXController extends GetxController {
  int tabIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("Dashboard");
    super.onReady();
  }

  void changeTabIndex(int index) {
    if (index != 2) {
      tabIndex = index;
      print("INDEX " + tabIndex.toString());
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
