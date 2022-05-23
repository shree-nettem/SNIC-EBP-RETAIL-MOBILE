import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:ebpv2/src/views/ui/auth/verification/identity_verification/identity_verification_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/personal_identification/personal_identification_required_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonalIdentificationRequiredScreen extends StatelessWidget {
  final PersonalIdentificationRequiredXController controller =
      Get.put(PersonalIdentificationRequiredXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'personal_identity_verification'.tr,
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
            Column(
              children: [
                IdentityButtonView(),
                SizedBox(height: 12),
                FacialButtonView(),
                SizedBox(height: 32),
                CustomButton(
                  title: 'next'.tr,
                  width: 114,
                  fontSize: 12,
                  isActive: true,
                  height: 26,
                  buttonAction: () {
                    controller.initializeJumio();
                  },
                ),
              ],
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
  final PersonalIdentificationRequiredXController controller;

  const IdentityButtonView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
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
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomLabel(
                      title: 'required'.tr,
                      color: Colors.red,
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
  final IdentityVerificationXController controller;

  const FacialButtonView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
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
                  title: 'facial_recognition'.tr,
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
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomLabel(
                    title: 'required'.tr,
                    color: Colors.red,
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
