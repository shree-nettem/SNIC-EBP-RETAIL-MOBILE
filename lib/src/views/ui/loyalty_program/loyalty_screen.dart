import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_divider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/loyalty_program_controller.dart';
import 'widget/loyalty_transaction_history_view.dart';

class LoyaltyScreen extends StatelessWidget {
  final LoyaltyPointsHistoryController controller =
      Get.put(LoyaltyPointsHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(
                title: "Loyalty Program",
                isActionButtonExist: true,
              ),
              SliverToBoxAdapter(
                child: LoyaltyHomeView(
                  controller: controller,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                        decoration: new BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: MyColors.GrayColor,
                              blurRadius: 8.0,
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .loyaltyTransactionHistoryList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return LoyaltyTransactionHistoryView(
                                        index: index);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LoyaltyHomeView extends StatelessWidget {
  final LoyaltyPointsHistoryController controller;

  const LoyaltyHomeView({this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoyaltyHelpView(controller: controller),
            CustomLabel(
              title: "Transaction History",
              color: MyColors.PrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              height: 2.4,
            ),
            CustomSpacer(value: 24),
          ],
        ),
      ),
    );
  }
}

class LoyaltyHelpView extends StatelessWidget {
  final LoyaltyPointsHistoryController controller;

  const LoyaltyHelpView({this.controller});

  @override
  Widget build(BuildContext context) {
    num points = 0.0;
    if (controller.loyaltyPointsDetails != null) {
      points = controller.loyaltyPointsDetails?.outstandingPoints?.toInt();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.stars_loyalty),
            CustomSpacer(
              value: 8,
              isHeight: false,
            ),
            Column(
              children: [
                CustomLabel(
                  title: "Current balance",
                  color: Color.fromRGBO(14, 43, 92, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                CustomSpacer(
                  value: 5,
                ),
                CustomLabel(
                  title: "${controller.remainingPoints.value} Points",
                  color: Color.fromRGBO(23, 126, 224, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
              ],
            ),
          ],
        ),
        CustomSpacer(
          value: 22,
        ),
        CustomDivider(),
        CustomSpacer(
          value: 22,
        ),
        CustomLabel(
          title: "How it works",
          color: MyColors.PrimaryColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          height: 2.1,
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 18,
              width: 18,
              child: Center(
                child: CustomLabel(
                  title: "1",
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: MyColors.PrimaryColor)),
            ),
            CustomSpacer(
              value: 8.0,
              isHeight: false,
            ),
            Expanded(
              child: CustomLabel(
                title: "How to Earn Points",
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
            ),
          ],
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_SMALL),
        CustomLabel(
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            maxLines: 20,
            height: 1.9,
            title:
                "• Downloads the application and enjoy immediate loyalty points added to your account\n"
                "• Refer a friend and get immediate loyalty points added to your account.\n"
                "• Purchase a new policy and get loyalty points towards the premium that you paid\n"
                "• Renew your policy from your mobile application and earn anniversary loyalty points in addition to your loyalty points earned on your paid premium."),
        CustomSpacer(value: Dimensions.PADDING_SIZE_LARGE),
        Row(
          children: [
            Container(
              height: 18,
              width: 18,
              child: Center(
                child: CustomLabel(
                  title: "2",
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: MyColors.PrimaryColor)),
            ),
            CustomSpacer(
              value: 8.0,
              isHeight: false,
            ),
            CustomLabel(
              title: "How to Redeem Points",
              color: MyColors.PrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
          ],
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_SMALL),
        CustomLabel(
            maxLines: 20,
            height: 1.9,
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            title: "• Redeem your earned points any time at check out. "),
        CustomSpacer(value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
        Center(
          child: CustomButton(
            title: "Transfer points",
            buttonAction: () {
              Get.toNamed(AppRoutes.LOYALTY_TRANSFER_POINTS);
            },
            height: 40,
            paddingWidth: 8,
            width: Get.width * 0.7,
          ),
        ),
        CustomSpacer(value: 42),
        CustomDivider(),
        CustomSpacer(value: 16),
      ],
    );
  }
}
