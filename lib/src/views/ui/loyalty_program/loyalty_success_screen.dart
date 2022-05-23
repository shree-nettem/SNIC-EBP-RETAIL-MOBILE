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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoyaltySuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "Loyalty Program",
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: LoyaltyProgramSuccessView(),
          ),
        ],
      ),
    );
  }
}

class LoyaltyProgramSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoyaltySuccessView(),
          ],
        ),
      ),
    );
  }
}

class LoyaltySuccessView extends StatelessWidget {
  const LoyaltySuccessView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            CustomSpacer(
              value: 34,
            ),
            SvgPicture.asset(Images.success_check_transfer),
            CustomSpacer(
              value: 20,
            ),
            CustomLabel(
              title: "Success",
              fontSize: 20,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              height: 1.7,
            ),
            CustomSpacer(
              value: 12,
            ),
            CustomLabel(
              title: "Points transferred successfully",
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              height: 1.9,
            ),
            CustomSpacer(
              value: 8,
            ),
            CustomLabel(
              title: "Ref number: #21341234",
              color: Color.fromRGBO(14, 43, 92, 1),
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
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
          title: "Current balance",
          color: Color.fromRGBO(14, 43, 92, 1),
          fontWeight: FontWeight.normal,
          fontSize: Dimensions.FONT_SIZE_DEFAULT,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        CustomSpacer(
          value: 8,
        ),
        CustomLabel(
          title: "100 Points",
          color: Color.fromRGBO(23, 126, 224, 1),
          fontWeight: FontWeight.w600,
          fontSize: 22,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        CustomSpacer(value: 20),
        Center(
          child: CustomButton(
            title: "Transfer again",
            buttonAction: () {
              Get.toNamed(AppRoutes.LOYALTY_TRANSFER_POINTS);
            },
            height: 40,
            width: Get.width * 0.7,
          ),
        ),
        CustomSpacer(value: 48),
        CustomLabel(
          title: "How would you rate your experience?",
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.FONT_SIZE_SMALL,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          height: 1.6,
        ),
        CustomSpacer(value: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.happy),
            CustomSpacer(
              value: 24,
              isHeight: false,
            ),
            SvgPicture.asset(Images.neutral),
            CustomSpacer(
              value: 24,
              isHeight: false,
            ),
            SvgPicture.asset(Images.sad),
          ],
        ),
      ],
    );
  }
}
