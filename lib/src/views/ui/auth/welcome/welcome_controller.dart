import 'package:ebpv2/src/utilities/images.dart';
import 'package:get/get.dart';

class WelcomeXController extends GetxController {
  int currentPos = 0;
  List<String> imgList = [
    Images.welcome_01,
    Images.welcome_02,
    Images.welcome_03,
    Images.welcome_04,
  ];
  bool autoPlay = true;

  @override
  void onInit() {
    super.onInit();
  }

  void autoPlaySlider(double visibleFraction) {
    var visiblePercentage = visibleFraction * 100;
    if (visiblePercentage == 100.0) {
      autoPlay = true;
    } else {
      autoPlay = false;
    }
    update();
  }

  void changed(int index) {
    currentPos = index;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
