import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/notification/notifications_model.dart';
import 'package:get/get.dart';

class NotificationXController extends GetxController {
  String token;

  List<TotalNotifications> totalNotifications;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getNotificationsList();
  }

  getNotificationsList() async {
    Result result = await DioClient().get(
        'Notification/GetUserNotificationMessagesList', token,
        isLoading: true);
    if (result is SuccessState) {
      var jsonData = List<TotalNotifications>.from(
          result.value.map((x) => TotalNotifications.fromJson(x)));
      if (jsonData is List<TotalNotifications>) {
        totalNotifications = jsonData;
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      // errorMessage(result.msg.error.toString());
    }
  }

  addedReadNotification(String messageID) async {
    Result result = await DioClient().put(
        'Notification/UpdateNotificationMessages?messageIds=$messageID', token,
        isLoading: false);
    if (result is SuccessState) {
    } else if (result is ErrorState) {
      print("failed");
    }
  }
}
