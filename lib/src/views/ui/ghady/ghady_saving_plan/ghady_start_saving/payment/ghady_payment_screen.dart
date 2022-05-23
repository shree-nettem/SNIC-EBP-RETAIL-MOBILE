import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/payment/ghady_payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/paymeny_options_logs.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GhadyPaymentView extends StatelessWidget {
  GhadyPaymentView({Key key}) : super(key: key);
  GhadyPaymentXController controller = Get.put(GhadyPaymentXController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 225,
                width: 2,
                color: MyColors.PrimaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: CustomLabel(
                        title: 'paymentMethod'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontSize: 14,
                      ),
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
                            title: 'BHD249',
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 1,
                      color: MyColors.PrimaryColor.withOpacity(0.3),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: CustomLabel(
                        title: 'paymentMethod'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontSize: 14,
                      ),
                    ),
                    PaymentOptionsLogo(),
                    CustomRadioButton(
                      text: 'debit'.tr,
                      value: controller.paymentOptions[0],
                      onTap: () {
                        controller.switchPaymentOptions(0);
                      },
                    ),
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
                    CustomRadioButton(
                      text: 'directDebit'.tr,
                      value: controller.paymentOptions[3],
                      onTap: () {
                        controller.switchPaymentOptions(3);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        title: 'confirm'.tr,
                        width: 114,
                        fontSize: 12,
                        height: 26,
                        buttonAction: () {},
                      ),
                    ),
                    CustomSpacer(
                      value: Dimensions.PADDING_SIZE_DEFAULT,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
