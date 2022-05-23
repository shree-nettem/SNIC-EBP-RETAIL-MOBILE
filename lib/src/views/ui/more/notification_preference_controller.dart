import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:get/get.dart';

import 'notification_preference_model.dart';

class NotificationPreferenceXController extends GetxController {
  RxBool switchNotificationValue = false.obs;
  RxBool switchEmailValue = false.obs;
  RxBool switchSMSValue = false.obs;
  RxBool isLoading = false.obs;
  RxBool hasNetworkError = false.obs;
  RxString token = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    getToken();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    var accessToken = await _sharedPreferencesHelper.getAccessToken;
    token.value = accessToken;
    fetchPreferences();
  }

  switchNotification() {
    switchNotificationValue.value =
        switchNotificationValue.value ? false : true;
    savePreferences();
  }

  switchEmailNotification() {
    switchEmailValue.value = switchEmailValue.value ? false : true;
    savePreferences();
  }

  switchSMSNotification() {
    switchSMSValue.value = switchSMSValue.value ? false : true;
    savePreferences();
  }

  /* GET PREFERENCE */
  void fetchPreferences() async {
    Result result = await DioClient()
        .get('Customer/GetPreference?id=NotificationPreferences', token.value);
    if (result is SuccessState) {
      isLoading.value = false;
      var jsonData = NotificationPreferencesModel.fromJson(result.value);
      if (jsonData is NotificationPreferencesModel) {
        switchEmailValue.value = jsonData.emails;
        switchSMSValue.value = jsonData.sMS;
        switchNotificationValue.value = jsonData.pushNotifications;
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      errorMessage("Please connect to the internet!");
    }
  }

  /* SAVE PREFERENCES */
  void savePreferences() async {
    isLoading.value = true;
    var requestMap = {
      "PushNotifications": switchNotificationValue.value,
      "Emails": switchEmailValue.value,
      "SMS": switchSMSValue.value
    };

    Result result = await DioClient().post(
        'Customer/SavePreference?id=NotificationPreferences', requestMap,
        token: token.value, isHeaderJsonType: true);

    if (result is SuccessState) {
      isLoading.value = false;
    } else if (result is ErrorState) {
      isLoading.value = false;
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      hasNetworkError.value = true;
      errorMessage("Please connect to the internet!");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
