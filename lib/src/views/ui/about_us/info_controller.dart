import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  String info = "";
  bool isInfoReceived = false;

  LocalizationController localizationController =
      Get.isRegistered<LocalizationController>()
          ? Get.find<LocalizationController>()
          : Get.put(LocalizationController(sharedPreferences: Get.find()));

  @override
  void onInit() {
    super.onInit();
  }

  void fetchInfo(code) async {
    Result result = await DioClient().get(
        'Account/GetInfoPageData?configurationId=$code&locale=${localizationController.locale.languageCode}',
        "");
    if (result is SuccessState) {
      info = result.value["detail"];
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
