import 'package:get/get.dart';

class NotificationsWebviewController extends GetxController {
  String webUrl;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      webUrl = Get.arguments['webUrl'];
    }
  }
}
