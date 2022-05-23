import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/model/issue_quote.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/insurance_payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/paymeny_options_logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentXController controller =
      Get.put(PaymentXController(), permanent: true);

  final MotorXController motorController = Get.isRegistered<MotorXController>()
      ? Get.find<MotorXController>()
      : Get.put(MotorXController());

  String originatedFlow;
  bool isPolicyfees,
      isSupplementaryBenifitsVisible,
      isVatVisible,
      isDiscountVisilbe;
  double supplimentBenifitTotal, policyFees, vat;
  IssueQuote quote;

  PaymentScreen(
    this.quote,
    this.originatedFlow, {
    this.supplimentBenifitTotal = 0.0,
    this.policyFees = 0.0,
    this.vat = 0.0,
    this.isSupplementaryBenifitsVisible = true,
    this.isDiscountVisilbe = false,
    this.isVatVisible = true,
    this.isPolicyfees = true,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.999,
            margin: const EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 600,
                        width: 2,
                        color: MyColors.themeColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      //Monthly Income
                      if (quote != null)
                        if (quote.actualPolicyName != null)
                          Flexible(
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: CustomLabel(
                                        title:
                                            "Motor Plan - ${quote.actualPolicyName.toUpperCase()}",
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            title: 'make_model'.tr,
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 14,
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Spacer(),
                                          Flexible(
                                            child: CustomLabel(
                                              textAlign: TextAlign.end,
                                              title:
                                                  '${quote.vehicleMake} ${quote.vehicleModel}',
                                              fontFamily: Constants
                                                  .FONT_SF_UI_TEXT_REGULAR,
                                              fontSize: 14,
                                              maxLines: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Row(
                                        children: [
                                          CustomLabel(
                                            title: 'registrationNo'.tr,
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 14,
                                            maxLines: 2,
                                          ),
                                          Spacer(),
                                          CustomLabel(
                                            title:
                                                '${quote.registrationNumber}',
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 14,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height: 1,
                                      color: MyColors.PrimaryColor.withOpacity(
                                          0.3),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: CustomLabel(
                                        title: 'redeemLoyaltypPoints'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CustomLabel(
                                          title: 'totalPoints'.tr,
                                          fontFamily:
                                              Constants.FONT_SF_UI_TEXT_REGULAR,
                                          fontSize: 10,
                                        ),
                                        Obx(() {
                                          return CustomLabel(
                                            title:
                                                "${controller.loyaltyPoints.value.toString()}"
                                                " (BHD ${controller.eligibleAmount.value})",
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 10,
                                          );
                                        })
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: CustomTextField(
                                              textController: controller.points,
                                              labelText: '',
                                              textInputType:
                                                  TextInputType.number,
                                              isDecimalAmount: true,
                                              // restrictSpecialCharecter: true,
                                              hintText: 'enterAountOfPoints'.tr,
                                              validator: (value) {
                                                return AppFormFieldValidator
                                                    .loyaltyPointValidator(
                                                        value,
                                                        loyalty:
                                                            controller.loyalty);
                                              },
                                              validate: true,
                                              isEnabled: true,
                                              onSaved: (value) {},
                                              onChanged: (value) {
                                                controller.discountAmount
                                                    .value = value;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GetBuilder<LocalizationController>(
                                            builder: (localizationController) =>
                                                CustomButton(
                                              title: 'apply'.tr,
                                              width: localizationController
                                                          .locale
                                                          .languageCode ==
                                                      'en'
                                                  ? 70
                                                  : 115,
                                              height: 30,
                                              buttonAction: () {
                                                // print(controller.points.text);
                                                controller.applyDiscount(
                                                    controller.points.text,
                                                    quote);
                                                // controller.setPlanSelected();
                                                //motorXController.expansionCardKey[1].currentState.collapse();
                                              },
                                              bgColor:
                                                  MyColors.VerticalDividerColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /* Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: CustomLabel(
                                    title: MyString.promoCode,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 14,
                                  ),
                                ),*/
                                    /* Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: CustomTextField(
                                          textController: controller.promoCode,
                                          labelText: '',
                                          hintText: MyString.enterPromoCode,
                                          validate: true,
                                          isEnabled: true,
                                          onSaved: (value) {},
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomButton(
                                        title: MyString.apply,
                                        width: 70,
                                        height: 30,
                                        buttonAction: () {
                                          // controller.setPlanSelected();
                                          //motorXController.expansionCardKey[1].currentState.collapse();
                                        },
                                        bgColor: MyColors.VerticalDividerColor,
                                      ),
                                    ],
                                  ),
                                ),*/
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height: 1,
                                      color: MyColors.PrimaryColor.withOpacity(
                                          0.3),
                                    ),
                                    Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: CustomLabel(
                                                title: 'plandetails'.tr,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'basicPremium'.tr,
                                                    fontFamily: Constants
                                                        .FONT_SF_UI_TEXT_REGULAR,
                                                    fontSize: 14,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title:
                                                        'BHD${quote.basicPremiumAmount}',
                                                    fontFamily: Constants
                                                        .FONT_SF_UI_TEXT_REGULAR,
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  quote.supplementaryBenefitsAmount >
                                                          0.0
                                                      ? true
                                                      : false,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    CustomLabel(
                                                      title:
                                                          'supplementaryBenifits'
                                                              .tr,
                                                      fontFamily: Constants
                                                          .FONT_SF_UI_TEXT_REGULAR,
                                                      fontSize: 14,
                                                    ),
                                                    Spacer(),
                                                    CustomLabel(
                                                      title:
                                                          'BHD${quote.supplementaryBenefitsAmount}',
                                                      fontFamily: Constants
                                                          .FONT_SF_UI_TEXT_REGULAR,
                                                      fontSize: 14,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: quote.stampDuty > 0
                                                  ? true
                                                  : false,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    CustomLabel(
                                                      title: 'policyFees'.tr,
                                                      fontFamily: Constants
                                                          .FONT_SF_UI_TEXT_REGULAR,
                                                      fontSize: 14,
                                                      maxLines: 2,
                                                    ),
                                                    Spacer(),
                                                    CustomLabel(
                                                      title:
                                                          'BHD${quote.stampDuty}',
                                                      fontFamily: Constants
                                                          .FONT_SF_UI_TEXT_REGULAR,
                                                      fontSize: 14,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'vat'.tr,
                                                    fontFamily: Constants
                                                        .FONT_SF_UI_TEXT_REGULAR,
                                                    fontSize: 14,
                                                    maxLines: 2,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title:
                                                        'BHD${quote.vatAmount.toStringAsFixed(3)}',
                                                    fontFamily: Constants
                                                        .FONT_SF_UI_TEXT_REGULAR,
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: controller.discountAmount
                                                          .value.isNotEmpty &&
                                                      controller
                                                          .isDiscountVisilbe
                                                  ? true
                                                  : false,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    CustomLabel(
                                                      title: 'discounts'.tr,
                                                      fontFamily: Constants
                                                          .FONT_SF_UI_TEXT_REGULAR,
                                                      fontSize: 14,
                                                      maxLines: 2,
                                                    ),
                                                    Spacer(),
                                                    // Obx(() {
                                                    // return
                                                    CustomLabel(
                                                      title:
                                                          'BHD ${controller.discountAmount.value}',
                                                      color: MyColors
                                                          .requiredFieldColor,
                                                      fontFamily: Constants
                                                          .FONT_SF_UI_TEXT_REGULAR,
                                                      fontSize: 14,
                                                    ),
                                                    // })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height: 1,
                                      color: MyColors.PrimaryColor.withOpacity(
                                          0.3),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Row(
                                        children: [
                                          CustomLabel(
                                            title: 'toBePaid'.tr,
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 14,
                                          ),
                                          Spacer(),
                                          CustomLabel(
                                            title:
                                                '${controller.calculateTotalPremeium(
                                              quote,
                                            )}',
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 5),
                                      height: 1,
                                      color: MyColors.PrimaryColor.withOpacity(
                                          0.3),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: CustomLabel(
                                        title: 'paymentMethod'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 16,
                                      ),
                                    ),
                                    PaymentOptionsLogo(),
                                    // CustomRadioButton(
                                    //   text: 'debit'.tr,
                                    //   value: controller.paymentOptions[0],
                                    //   onTap: () {
                                    //     controller.switchPaymentOptions(0);
                                    //   },
                                    // ),
                                    CustomRadioButton(
                                      text: 'credit'.tr,
                                      value: controller.paymentOptions[1],
                                      onTap: () {
                                        controller.switchPaymentOptions(1);
                                      },
                                    ),
                                    CustomRadioButton(
                                      text: 'benifitPay'.tr,
                                      value: controller.paymentOptions[2],
                                      onTap: () {
                                        controller.switchPaymentOptions(2);
                                      },
                                    ),
                                    // CustomRadioButton(
                                    //   text: 'directDebit'.tr,
                                    //   value: controller.paymentOptions[3],
                                    //   onTap: () {
                                    //     controller.switchPaymentOptions(3);
                                    //   },
                                    // ),
                                  ]),
                            ),
                          ),

                      // _buildSaveButton()
                    ]),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        title: 'cancel'.tr,
                        width: 90,
                        height: 30,
                        buttonAction: () {
                          // controller.setPlanSelected();
                          try {
                            if (motorController
                                    .expansionCardKey[2].currentState !=
                                null) {
                              return motorController
                                  .expansionCardKey[2].currentState
                                  .collapse();
                            }
                            return Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                        title: 'pay'.tr,
                        width: 90,
                        height: 30,
                        buttonAction: () {
                          if (controller.paymentOptions[2]) {
                            controller.proceedToBenefitPayment(
                              this.originatedFlow,
                              quote,
                            );
                          } else if (controller.paymentOptions[1]) {
                            controller.credMaxPayment(
                                this.originatedFlow, quote);
                          }
                          // controller.setPlanSelected();
                          //motorXController.expansionCardKey[1].currentState.collapse();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
