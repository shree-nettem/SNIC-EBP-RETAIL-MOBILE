import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/payment_type_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/plan_screen.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/motor_controller.dart';
import '../../controller/motor_paln_Controller.dart';

class MotorPalnScreen extends StatelessWidget {
  final MotorPalnXController controller = Get.put(MotorPalnXController());
  final MotorXController motorXController = Get.find();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Container(
            height: !controller.isPlanSelected
                ? MediaQuery.of(context).size.height * 1.255
                : !controller.isCashFlowVisible && !controller.isLoanFlowVisible
                    ? MediaQuery.of(context).size.height * 0.15
                    : controller.isCashFlowVisible
                        ? MediaQuery.of(context).size.height * 0.95
                        : controller.isLoanFlowVisible &&
                                (!controller.isBankFlowVisible &&
                                    !controller.isCustomerFlowVisible)
                            ? MediaQuery.of(context).size.height * 0.45
                            : controller.isLoanFlowVisible &&
                                    controller.isCustomerFlowVisible
                                ? MediaQuery.of(context).size.height * 1.2
                                : controller.isLoanFlowVisible &&
                                        controller.isBankFlowVisible
                                    ? MediaQuery.of(context).size.height * 0.59
                                    : MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Visibility(
                    visible: controller.isPlanSelected ? false : true,
                    child: Column(
                      children: [
                        PlanScreen(),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                motorXController
                                    .expansionCardKey[1].currentState
                                    .collapse();
                              },
                              child: CustomBackNextutton(
                                isBackButton: true,
                              ),
                            ),
                            Spacer(),
                            CustomButton(
                              title: !controller.isPlanSelected
                                  ? 'next'.tr
                                  : 'confirm'.tr,
                              width: 90,
                              height: 26,
                              buttonAction: () {
                                // if (formKey.currentState.validate()) {
                                if (controller.eligibleOption.value
                                        .toLowerCase() ==
                                    "select") {
                                  errorMessage('pleaseSelectRSAoption'.tr);
                                } else {
                                  if (controller
                                      .premium
                                      .data[controller.selectedIndex.value]
                                      .hasCalculatePremium
                                      .value) {
                                    if (!controller.isPlanSelected) {
                                      controller.setPlanSelected();
                                    }
                                    controller.isRecommendedVisible = controller
                                        .premium
                                        .data[controller.selectedIndex.value]
                                        .recommended;
                                    controller.postDraft(
                                        callCalculatePremium: true);
                                  } else {
                                    errorMessage(
                                        'pleaseCalculatePremiumFirst'.tr);
                                  }
                                }
                                // }
                                //motorXController.expansionCardKey[1].currentState.collapse();
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
                Visibility(
                    visible: controller.isPlanSelected ? true : false,
                    child: PaymentTypeScreen()),
              ],
            ),
          );
        });
  }
}
