import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final bool isSupplementaryBenifitsVisible,
      isDiscountVisilbe,
      isVatVisible,
      isPolicyfees;
  final MotorXController motorXController = Get.find();
  final VehicleDetailsXController vehicleDetailsXController = Get.find();
  final MotorPalnXController planXController = Get.find();

  PaymentDetailsScreen({
    this.isSupplementaryBenifitsVisible = true,
    this.isDiscountVisilbe = true,
    this.isVatVisible = true,
    this.isPolicyfees = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: planXController
                      .premium
                      .data[planXController.selectedIndex.value]
                      .hasCalculatePremium
                      .value ==
                  true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: CustomLabel(
                          title: 'plandetails'.tr,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            CustomLabel(
                              title: 'basicPremium'.tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              fontSize: 14,
                            ),
                            Spacer(),
                            CustomLabel(
                              title:
                                  'BHD${planXController.premium.data[planXController.selectedIndex.value].calculatePremiumOutput != null ? planXController.premium.data[planXController.selectedIndex.value].calculatePremiumOutput.strBasicPremium : planXController.premium.data[planXController.selectedIndex.value].startingFrom.toString()}',
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return planXController.supplimentBenifitTotal.value !=
                                0.0
                            ? Visibility(
                                visible: isSupplementaryBenifitsVisible &&
                                        planXController
                                                .supplimentBenifitTotal.value >
                                            0.0
                                    ? true
                                    : false,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      CustomLabel(
                                        title: 'supplementaryBenifits'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                      Spacer(),
                                      CustomLabel(
                                        title:
                                            'BHD${planXController.calculateSupplementaryBenifitsTotal()}',
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      }),
                      Obx(() {
                        return planXController.policyFees.value != 0.0
                            ? Visibility(
                                visible: isPolicyfees ? true : false,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      CustomLabel(
                                        title: 'policyFees'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                        maxLines: 2,
                                      ),
                                      Spacer(),
                                      CustomLabel(
                                        title:
                                            'BHD${planXController.policyFees.value.toString()}',
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      }),
                      if (planXController
                              .premium
                              .data[planXController.selectedIndex.value]
                              .calculatePremiumOutput !=
                          null)
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              CustomLabel(
                                title: 'supplementaryBenifits'.tr,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 14,
                              ),
                              Spacer(),
                              CustomLabel(
                                title:
                                    'BHD${planXController.premium.data[planXController.selectedIndex.value].calculatePremiumOutput.strSupplementaryBenefit} ',
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                      Visibility(
                        visible: isVatVisible && planXController.vat.value != 0
                            ? true
                            : false,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              CustomLabel(
                                title: 'vat'.tr,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 14,
                                maxLines: 2,
                              ),
                              Spacer(),
                              CustomLabel(
                                title:
                                    'BHD${planXController.vat.value.toStringAsFixed(3)}',
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isDiscountVisilbe ? true : false,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: [
                              CustomLabel(
                                title: 'discounts'.tr,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 14,
                                maxLines: 2,
                              ),
                              Spacer(),
                              CustomLabel(
                                title: 'BHD10',
                                color: MyColors.requiredFieldColor,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Center(
                        child: CustomButton(
                            width: 200,
                            title: "Calculate Premium",
                            buttonAction: () {
                              if (planXController.eligibleOption.value
                                      .toLowerCase() ==
                                  "select") {
                                errorMessage('pleaseSelectRSAoption'.tr);
                              } else {
                                planXController.getPlanDetails(
                                    paymentMethodCall: false,
                                    updateDetails: true,
                                    fromCalculatePremiumtn: true);
                                // planXController.update();
                              }
                              // planXController.calculateSupplementaryBenifitsTotal();
                            }),
                      )
                    ]),
        ));
  }
}
