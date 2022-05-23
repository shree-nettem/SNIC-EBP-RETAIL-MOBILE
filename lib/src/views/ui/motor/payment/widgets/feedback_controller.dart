import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/payment/model/feedback_model.dart';
import 'package:get/get.dart';

class InnerFeedbackXController extends GetxController {
  String token;

  List<FeedbackValue> totalFeedbackValues = [];
  int currentFeedbackValue = 0;
  bool feedbackAddedToBackend = false;

  @override
  void onInit() {
    getToken();

    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  getFeedbackData(int selectedFeedbackValue, String currentProduct) async {
    currentFeedbackValue = selectedFeedbackValue;
    Result result =
        await DioClient().get('Customer/GetPreference/FeedBack', token);
    if (result is SuccessState) {
      if (result.value != null) {
        var jsonData = List<FeedbackValue>.from(
            result.value.map((x) => FeedbackValue.fromJson(x)));
        if (jsonData is List<FeedbackValue>) {
          totalFeedbackValues = jsonData;
        }
      }

      FeedbackValue newFeedbackData = FeedbackValue(
          feedbackValue: selectedFeedbackValue,
          feedbackCaption: selectedFeedbackValue == -1
              ? "Unsatisfied"
              : selectedFeedbackValue == 1
                  ? "Satisfied"
                  : "Neutral",
          date: DateTime.now(),
          product: currentProduct ?? "");

      totalFeedbackValues.add(newFeedbackData);
      saveFeedback();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  saveFeedback() async {
    var requestMap =
        List<dynamic>.from(totalFeedbackValues.map((x) => x.toJson()));
    print(requestMap.length);
    Result result = await DioClient().post(
        'Customer/SavePreference/FeedBack', requestMap,
        token: token, isPostData: true, isHeaderJsonType: true);

    if (result is SuccessState) {
      feedbackAddedToBackend = true;
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }
}
