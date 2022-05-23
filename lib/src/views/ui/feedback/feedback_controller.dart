import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../utilities/ui_constants.dart';
import '../../../utilities/utils.dart';
import 'package:get/get.dart';

import 'feedback_repository.dart';

class FeedbackXController extends GetxController {
  final FeedbackRepository _repository = FeedbackRepository();
  var token;
  bool isVisible = true;

  @override
  void onInit() {
    getFeedBacks();
    AppHelper.logout();
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print("TOKEN $token");
  }

  getFeedBacks() async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.getFeedBack(token);
    Get.back();
    if (result is SuccessState) {
      if (result.value != null) {
        print("Success List");
      } else {
        print("Success Null");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
