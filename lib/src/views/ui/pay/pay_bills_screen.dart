import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/pay/pay_bills_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PayBillsScreen extends StatelessWidget {
  final PayBillsXController controller = Get.put(PayBillsXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: MyColors.MainColor,
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(title: "Pay my bills"),
              SliverFillRemaining(
                hasScrollBody: false,
                child: PayBillsView(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PayBillsView extends StatelessWidget {
  const PayBillsView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
            left: Dimensions.FONT_SIZE_EXTRA_SMALL,
            right: Dimensions.FONT_SIZE_EXTRA_SMALL,
            bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE),
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: MyColors.GrayColor,
              blurRadius: 22.0,
              offset: Offset(
                0.0,
                6.0,
              ),
            ),
          ],
        ),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          child: Container(
            width: Get.width,
            margin: const EdgeInsets.all(
              Dimensions.PADDING_SIZE_LARGE,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width * 0.05,
                  margin: const EdgeInsets.only(
                      right: Dimensions.PADDING_SIZE_DEFAULT),
                  child: VerticalDivider(
                    color: MyColors.PrimaryColor,
                    thickness: 2,
                  ),
                ),
                Container(
                  width: Get.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomLabel(
                        title: "Review and Pay",
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      ),
                      CustomLabel(
                        title: "Motor Plan - Ultimate",
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomLabel(
                              title: "Total to be paid",
                              color: MyColors.PrimaryColor,
                            ),
                            CustomLabel(
                              title: "BHD 200",
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ],
                        ),
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomLabel(
                              title: "Loyalty Points earned",
                              color: MyColors.PrimaryColor,
                            ),
                            CustomLabel(
                              title: "+2.5pts",
                              color: MyColors.PrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
                      ),
                      Container(
                        child: Divider(
                          color: MyColors.DividerColor,
                          thickness: 1,
                        ),
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
                      ),
                      CustomLabel(
                        title: 'paymentMethod'.tr,
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Images.visa,
                          ),
                          SvgPicture.asset(
                            Images.master_card,
                            // width: 25,
                            // height: 25,
                          ),
                          SvgPicture.asset(
                            Images.amex,
                          ),
                          // SvgPicture.asset(
                          //   Images.benefit_pay,
                          //   // width: 25,
                          //   // height: 35,
                          // ),
                          SvgPicture.asset(
                            Images.benefit,
                            // width: 25,
                            // height: 25,
                          ),
                          SvgPicture.asset(
                            Images.paypal,
                            // width: 25,
                            // height: 25,
                          ),
                        ],
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: 1,
                            activeColor: Colors.blue,
                            onChanged: (value) {},
                          ),
                          CustomLabel(
                            title: 'debit'.tr,
                            fontWeight: FontWeight.bold,
                            color: MyColors.PrimaryColor,
                            fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            groupValue: 1,
                            value: 2,
                            activeColor: Colors.blue,
                            onChanged: (value) {},
                          ),
                          CustomLabel(
                            title: 'credit'.tr,
                            fontWeight: FontWeight.bold,
                            color: MyColors.PrimaryColor,
                            fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            groupValue: 1,
                            value: 3,
                            activeColor: Colors.blue,
                            onChanged: (value) {},
                          ),
                          CustomLabel(
                            title: 'benifitPay'.tr,
                            fontWeight: FontWeight.bold,
                            color: MyColors.PrimaryColor,
                            fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            groupValue: 1,
                            value: 4,
                            activeColor: Colors.blue,
                            onChanged: (value) {},
                          ),
                          CustomLabel(
                            title: 'directDebit'.tr,
                            fontWeight: FontWeight.bold,
                            color: MyColors.PrimaryColor,
                            fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          ),
                        ],
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                              title: 'cancel'.tr,
                              width: 110.0,
                              isActive: false,
                              buttonAction: () {}),
                          CustomButton(
                              title: 'pay_now'.tr,
                              width: 110.0,
                              buttonAction: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
