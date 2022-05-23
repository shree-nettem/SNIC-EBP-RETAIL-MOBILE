import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GhadyPaymentXController extends GetxController {
  final formKey = GlobalKey<FormState>();
  List<bool> paymentOptions;

  TextEditingController points, promoCode;

  @override
  void onInit() {
    // TODO: implement onInit

    paymentOptions = [false, false, false, false];
    points = TextEditingController();
    promoCode = TextEditingController();
    super.onInit();
  }

  switchPaymentOptions(index) {
    for (int i = 0; i < paymentOptions.length; i++) {
      paymentOptions[i] = i == index;
    }
    print(paymentOptions[index]);
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    points.dispose();
    promoCode.dispose();
    super.onClose();
  }
}
