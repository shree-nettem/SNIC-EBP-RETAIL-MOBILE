import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../controller/motor_paln_Controller.dart';

class CarPaymentType extends StatelessWidget {
  final MotorPalnXController controller = Get.find();
  final MotorXController motorXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          CustomLabel(
            title: 'carPayment'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 10,
          ),
          CustomRadioButton(
            text: 'cash'.tr,
            value: controller.paymentType[0],
            onTap: () {
              controller.switchPaymentType(0);
            },
          ),
          CustomRadioButton(
            text: 'loan'.tr,
            value: controller.paymentType[1],
            onTap: () {
              controller.switchPaymentType(1);
            },
          ),
        ]));
  }
}
