import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/claims/claims_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claims_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/success_claim_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/enter_claim_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../router/app_routes.dart';
import 'medical_claim_screen_controller.dart';
import 'submit_claim/submit_claim_screen_controller.dart';

class SuccessClaimScreen extends StatelessWidget {
  SuccessClaimScreen({Key key}) : super(key: key);

  final SuccessClaimXController _controller =
      Get.put(SuccessClaimXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => _controller.isFromMedicalClaim ? false : true,
        child: CustomScrollView(
          slivers: <Widget>[
            CustomSilverBar(
              title: "claimSubmitted".tr,
              isBackButtonExist: _controller.isFromMedicalClaim ? false : true,
              isActionButtonExist: false,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  color: Colors.white, child: _medicalClaimUI(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget _medicalClaimUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      color: Colors.white,
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: SvgPicture.asset(
            Images.payment_success,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 10),
          child: CustomLabel(
            title: "congratulations".tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomLabel(
            textAlign: TextAlign.center,
            title: "claimSubmittedMessage".tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            maxLines: 10,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomLabel(
            title: "${"claimNumber".tr}: #${_controller.claimId}",
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
        ),
        _viewClaimsButton(context, "viewClaims".tr),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
        ),
        FeedBackView(
          productName: _controller.fromProductName,
        )
      ]),
    );
  }

  Widget _viewClaimsButton(
    BuildContext context,
    String title,
  ) {
    return Center(
      child: CustomButton(
        title: title,
        width: MediaQuery.of(context).size.width / 2 + 50,
        fontSize: 12,
        paddingWidth: 10,
        height: 40,
        buttonAction: () {
          //Get.back();
          if (_controller.isFromMedicalClaim) {
            Get.find<EnterClaimDetailsXController>().clearSavedData();
            Get.find<SubmitClaimScreenXController>().isDetailsAdded = false;
            Get.find<MedicalClaimScreenXController>()
                .tabController
                .animateTo(1);
            Get.back();
            Get.find<MyClaimsScreenXController>().getMedicalClaims();
          } else {
            // Get.find<MyClaimsScreenXController>().refreshedData();
            Get.offAndToNamed(AppRoutes.MY_CLAIMS_DETAILS, arguments: {
              'requestID': _controller.claimId,
              'flow': 'Motor',
              'claimType': _controller.claimType ?? ""
            });
            // Get.find<ClaimScreenXController>().tabController.animateTo(1);
          }
        },
      ),
    );
  }
}
