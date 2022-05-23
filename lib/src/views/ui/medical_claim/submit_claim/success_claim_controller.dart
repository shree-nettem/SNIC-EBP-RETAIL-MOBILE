import 'package:get/get.dart';

class SuccessClaimXController extends GetxController {
  bool isFromMedicalClaim = false;
  String claimId = "";
  String fromProductName = "";
  String claimType;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      claimId = Get.arguments['claimId'];
      isFromMedicalClaim = Get.arguments['isFromMedical'] ?? false;
      fromProductName = Get.arguments['fromProductName'] ?? "";
      claimType = Get.arguments['claim_type'] ?? "";
    }
  }
}
