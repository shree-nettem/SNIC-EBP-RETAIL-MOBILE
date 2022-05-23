import 'package:get/get.dart';

class MyBenefitsXController extends GetxController {
  bool isMedicalTab = false;
  bool isLifeTab = false;
  bool isMedicalClicked = false;
  bool isLifeClicked = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      isMedicalTab = Get.arguments['isMedical'];
      isLifeTab = Get.arguments['isLife'];
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
