import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/paymeny_options_logs.dart';
import 'package:ebpv2/src/views/ui/pay/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralPaymentScreen extends StatelessWidget {
  GeneralPaymentController controller = Get.put(GeneralPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: ConditionalWillPopScope(
        shouldAddCallback: Platform.isAndroid ? true : false,
        onWillPop: () async {
          Get.back();
          return false;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            CustomSilverBar(
              title: 'pendingPayments'.tr,
              info: "motor_claims_help_text".tr,
              isBackButtonExist: true,
              isActionButtonExist: true,
              onBackClick: () {
                Get.back();
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
                child: GetBuilder(
                  init: controller,
                  builder: (_) {
                    return paymentView();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentView() {
    return Container(
      margin: EdgeInsets.all(35.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  CustomLabel(
                    title: controller.item.type,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  Spacer(),
                  CustomLabel(
                    title: '${controller.item.status}',
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: CustomLabel(
                title: '${controller.item.description}',
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
                maxLines: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              height: 1,
              color: MyColors.PrimaryColor.withOpacity(0.3),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: CustomLabel(
                title: 'redeemLoyaltypPoints'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                CustomLabel(
                  title: 'totalAmount'.tr + " :",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 10,
                ),
                CustomLabel(
                  title: controller.loyalty != null
                      ? 'BHD ${controller.loyalty.result.eligibleAmount}'
                      : "",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 10,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      textController: controller.points,
                      labelText: '',
                      textInputType: TextInputType.number,
                      isDecimalAmount: true,
                      // restrictSpecialCharecter: true,
                      hintText: 'enterAountOfPoints'.tr,
                      validator: (value) {
                        return AppFormFieldValidator.loyaltyPointValidator(
                            value,
                            loyalty: controller.loyalty);
                      },
                      validate: true,
                      isEnabled: true,
                      onSaved: (value) {},
                      onChanged: (value) {
                        controller.discountAmount.value = value;
                        if (controller.points.text.isNotEmpty) {
                          try {
                            if (double.parse(controller.points.text) == 0) {
                              controller.isDiscountVisilbe = false;
                              controller.update();
                            }
                          } catch (e) {}
                        } else {
                          controller.isDiscountVisilbe = false;
                          controller.update();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GetBuilder<LocalizationController>(
                    builder: (localizationController) => CustomButton(
                      title: 'apply'.tr,
                      width: localizationController.locale.languageCode == 'en'
                          ? 70
                          : 115,
                      height: 30,
                      buttonAction: () {
                        controller.applyDiscount(controller.points.text);
                        // controller.setPlanSelected();
                        //motorXController.expansionCardKey[1].currentState.collapse();
                      },
                      bgColor: MyColors.VerticalDividerColor,
                    ),
                  ),
                  // CustomButton(
                  //   title: 'apply'.tr,
                  //   width: 70,
                  //   height: 30,
                  //   buttonAction: () {
                  //     controller.applyDiscount(controller.points.text);
                  //     // controller.setPlanSelected();
                  //     //motorXController.expansionCardKey[1].currentState.collapse();
                  //   },
                  //   bgColor: MyColors.VerticalDividerColor,
                  // ),
                ],
              ),
            ),
            Visibility(
              visible: controller.discountAmount.value.isNotEmpty &&
                      (controller.isDiscountVisilbe ?? true)
                  ? true
                  : false,
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
                    // Obx(() {
                    // return
                    CustomLabel(
                      title: 'BHD ${controller.discountAmount.value}',
                      color: MyColors.requiredFieldColor,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    // })
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              height: 1,
              color: MyColors.PrimaryColor.withOpacity(0.3),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  CustomLabel(
                    title: 'toBePaid'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                  ),
                  Spacer(),
                  CustomLabel(
                    title: 'BHD ${controller.calculateTotalToPaid()}',
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 5),
              height: 1,
              color: MyColors.PrimaryColor.withOpacity(0.3),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: CustomLabel(
                title: 'paymentMethod'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
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
                debugPrint("Clicked!");
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
                      Get.back();
                      // controller.setPlanSelected();
                      //motorXController.expansionCardKey[1].currentState.collapse();
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
                        controller.proceedToBenefitPayment(controller.item);
                      } else if (controller.paymentOptions[1]) {
                        // controller.closeFullyUsedPoints();
                        controller.credMaxPayment(controller.item);
                        // controller.showBottomSheetDialoug(controller.item);
                      }
                      // controller.setPlanSelected();
                      //motorXController.expansionCardKey[1].currentState.collapse();
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
