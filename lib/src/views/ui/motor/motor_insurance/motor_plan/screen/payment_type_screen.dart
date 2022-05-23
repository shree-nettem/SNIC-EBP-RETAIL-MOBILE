import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/car_payment_type.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/cash_payment.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/loan_payment_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/whatsapp_deep_link.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentTypeScreen extends StatelessWidget {
  final MotorPalnXController controller = Get.find();
  final MotorXController motorXController = Get.find();
  final VehicleDetailsXController vehicleDetailsXController = Get.find();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: !controller.isCashFlowVisible &&
                        !controller.isLoanFlowVisible
                    ? 85
                    : controller.isCashFlowVisible && !controller.isQuotIssued
                        ? 400
                        : controller.isCashFlowVisible &&
                                controller.isQuotIssued
                            ? 600
                            : controller.isLoanFlowVisible &&
                                    !controller.isQuotIssued &&
                                    (!controller.isBankFlowVisible &&
                                        !controller.isCustomerFlowVisible)
                                ? 270
                                : controller.isLoanFlowVisible &&
                                        controller.isCustomerFlowVisible &&
                                        controller.isQuotIssued
                                    ? 800
                                    : controller.isLoanFlowVisible &&
                                            controller.isCustomerFlowVisible &&
                                            !controller.isQuotIssued
                                        ? 600
                                        : controller.isLoanFlowVisible &&
                                                controller.isBankFlowVisible
                                            ? 360
                                            : 100,
                width: 2,
                color: MyColors.themeColor,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  children: [
                    IgnorePointer(
                      ignoring: controller.isQuotIssued ? true : false,
                      child: CarPaymentType(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                        visible: controller.isCashFlowVisible ? true : false,
                        child: CashPayment()),
                    Visibility(
                        visible: controller.isLoanFlowVisible &&
                                vehicleDetailsXController.isBrandNew[0]
                            ? true
                            : false,
                        child: WhatsAppDeepLinkView()),
                    Visibility(
                      visible: controller.isLoanFlowVisible &&
                              vehicleDetailsXController.isBrandNew[1] &&
                              (!controller.isBankFlowVisible &&
                                  !controller.isCustomerFlowVisible)
                          ? true
                          : false,
                      child: LoanPayment(formKey),
                    ),
                    Visibility(
                        visible: controller.isLoanFlowVisible &&
                                vehicleDetailsXController.isBrandNew[1] &&
                                controller.isCustomerFlowVisible
                            ? true
                            : false,
                        child: Column(
                          children: [
                            LoanPayment(formKey),
                            SizedBox(
                              height: 15,
                            ),
                            CashPayment(),
                          ],
                        )),
                    Visibility(
                        visible: vehicleDetailsXController.isBrandNew[1] &&
                                controller.isLoanFlowVisible &&
                                controller.isBankFlowVisible
                            ? true
                            : false,
                        child: Column(
                          children: [
                            LoanPayment(formKey),
                            SizedBox(
                              height: 15,
                            ),
                            WhatsAppDeepLinkView(),
                          ],
                        )),
                  ],
                ),
              )
            ]));
  }
}
