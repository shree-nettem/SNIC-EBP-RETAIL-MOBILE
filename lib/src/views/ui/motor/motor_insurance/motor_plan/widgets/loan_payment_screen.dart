import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoanPayment extends StatelessWidget {
  final MotorPalnXController controller = Get.find();
  final MotorXController motorXController = Get.find();
  GlobalKey<FormState> formKey;

  LoanPayment(this.formKey);

  @override
  Widget build(BuildContext context) {
    return Form(
      key:formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(
              title: 'selectBank'.tr,
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropDown(
              label: controller.selectedBankName.value,
              options: Constants.baseBanks,
              validator: AppFormFieldValidator.generalDropDownValidator,
              onChanged: (val) {
                AppFormFieldValidator.generalDropDownValidator(val);
                controller.setBank(val);
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomLabel(
              title: 'ownerRegistration'.tr,
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 5,
            ),
            CustomRadioButton(
              text: 'customerName'.tr,
              value: controller.ownership[0],
              onTap: () {
                controller.switchOwnership(0);
              },
            ),
            CustomRadioButton(
              text: 'bankName'.tr,
              value: controller.ownership[1],
              onTap: () {
                controller.switchOwnership(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
