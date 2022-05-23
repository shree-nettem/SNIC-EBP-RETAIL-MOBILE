import 'package:get/get.dart';

class SelectYourStrategyXController extends GetxController {
  RxList<bool> isBrandNew = [true, false, false, false].obs;

  List<String> makeYearList = ["SELECT"];

  RxString makeYear = "SELECT".obs;

  updateRadioButton(int index) {
    for (int i = 0; i < isBrandNew.length; i++) {
      isBrandNew[i] = i == index;
    }

    update();
  }
}
