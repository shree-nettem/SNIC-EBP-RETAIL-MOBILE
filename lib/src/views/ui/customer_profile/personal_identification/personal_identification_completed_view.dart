import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:ebpv2/src/views/ui/customer_profile/personal_identification/personal_identification_completed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PersonalIdentificationCompletedScreen extends StatelessWidget {
  final PersonalIdentificationCompletedXController controller =
      Get.put(PersonalIdentificationCompletedXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "Identity Verification",
            isBackButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return identityVerificationView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget identityVerificationView() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MyColors.PrimaryColor),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: MyColors.PrimaryColor,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.PrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: Color.fromRGBO(209, 215, 219, 1),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromRGBO(209, 215, 219, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Visibility(
              visible: !controller.isAnalyzed,
              child: Column(
                children: [
                  IdentityButtonView(controller: controller),
                  SizedBox(height: 12),
                  FacialButtonView(controller: controller),
                  SizedBox(height: 32),
                  CustomButton(
                    title: 'Next',
                    width: 114,
                    fontSize: 12,
                    isActive: true,
                    height: 26,
                    buttonAction: () {
                      controller.analyse(true);
                      controller.getVerificationResponse();
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.isAnalyzed,
              child: Column(
                children: [
                  CustomLabel(
                    title: "Analyzing your biometric data",
                    height: 1.9,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 56,
                  ),
                  // SvgPicture.asset(Images.analysis),
                  if (controller.showAnimation)
                    Lottie.asset(
                      Images.analyze,
                      height: 184,
                      width: 184,
                      animate: true,
                      onLoaded: (composition) {
                        controller.animationController
                          ..duration = composition.duration
                          ..reset()
                          ..forward();
                      },
                    ),
                  SizedBox(
                    height: 56,
                  ),
                  CustomLabel(
                    title: "This may take a few minutes, Please wait ",
                    height: 1.8,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                ],
              ),
            ),
            Expanded(
              child: CommonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class IdentityButtonView extends StatelessWidget {
  final PersonalIdentificationCompletedXController controller;

  const IdentityButtonView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36),
      height: Get.height * 0.09,
      child: Card(
        elevation: 6,
        color: Colors.white,
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
              SizedBox(width: 8),
                SvgPicture.asset(
                  Images.verify_cpr,
                  color: MyColors.PrimaryColor,
                ),
                SizedBox(width: 10),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomLabel(
                    title: 'verify_cpr_id'.tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColors.PrimaryColor,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    color: MyColors.VerticalDividerColor,
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomLabel(
                      title: 'completed'.tr,
                      color: MyColors.VerticalDividerColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FacialButtonView extends StatelessWidget {
  final PersonalIdentificationCompletedXController controller;

  const FacialButtonView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36),
      height: Get.height * 0.09,
      child: Card(
        elevation: 6,
        color: Colors.white,
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 16),
                SvgPicture.asset(
                  Images.identity_scan,
                  color: MyColors.PrimaryColor,
                ),
                SizedBox(width: 10),
                CustomLabel(
                  title: "Facial Recognition ",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: MyColors.PrimaryColor,
                ),
              ],
            ),
            Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    color: MyColors.VerticalDividerColor,
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomLabel(
                    title: "Completed",
                    color: MyColors.VerticalDividerColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
