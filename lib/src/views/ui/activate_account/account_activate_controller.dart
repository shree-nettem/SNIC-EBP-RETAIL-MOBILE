import '../../../utilities/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountActivateXController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  openAlertDialog() {
    Utils.showAlertDialogHelp(Get.context, "Kindly send your request to", "Ok");
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
