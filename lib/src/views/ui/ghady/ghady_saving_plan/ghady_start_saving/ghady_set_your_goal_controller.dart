import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/ghady_completed_retirment_model.dart';
import 'package:get/get.dart';

class GhadySetYourGoalXController extends GetxController {
  RxList<bool> selectedGoal = [true, false, false].obs;
  int selectedGoalIndex = 0;

  List<String> retireAge = ["SELECT"];

  RxString makeYear = "SELECT".obs;
  String token;

  bool alreadyExistsRetirmetPlan = false;
  CompletedRetirmentRequest existedRetirmentData;
  int currentStep = 1;

  updateRadioButton(int index) {
    for (int i = 0; i < selectedGoal.length; i++) {
      selectedGoal[i] = i == index;
      selectedGoalIndex = index;
    }

    update();
  }

  @override
  void onInit() {
    getToken();

    super.onInit();
    var list = new List<String>.generate(40, (i) => (40 + i).toString());
    retireAge.addAll(list);
  }

  changeCurrentStep({int step = 1}) {
    currentStep = step;
    update();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getRetirmentData();
  }

  //check for previous retirmet files
  getRetirmentData() async {
    Result result = await DioClient()
        .get('Saving/GetUncompletedRequestInput/?productCode=SS01RE', token);
    if (result is SuccessState) {
      if (result.value != null && result.value != "") {
        var jsonData = CompletedRetirmentRequest.fromJson(result.value);
        existedRetirmentData = jsonData;
        alreadyExistsRetirmetPlan = true;
        print(jsonData.id);
      } else {
        alreadyExistsRetirmetPlan = false;
      }

      // totalBenificiaries = jsonData;
      update();
    } else if (result is ErrorState) {
      // Get.back();
      // errorMessage(result.msg.error.toString());
    }
  }
}
