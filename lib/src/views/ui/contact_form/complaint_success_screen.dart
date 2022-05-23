import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/contact_form/contact_form_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ComplaintSuccessScreen extends StatelessWidget {
  const ComplaintSuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => false,
        child: CustomScrollView(
          slivers: <Widget>[
            CustomSilverBar(
              title: 'feedback'.tr,
              isBackButtonExist: false,
              isActionButtonExist: false,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child:
                  Container(color: Colors.white, child: _feedbackUI(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget _feedbackUI(BuildContext context) {
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
            title: 'message_Sent'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomLabel(
            textAlign: TextAlign.center,
            title: 'message_sent_msg'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            maxLines: 10,
          ),
        ),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
        ),
        _viewClaimsButton(context, 'view_complaint_status'.tr, action: () {
          Get.find<ContactFormXController>().tabController.animateTo(1);
          Get.back();
        }),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        _viewClaimsButton(context, 'home'.tr, action: () {
          Get.back();
          Get.back();
        }),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
        ),
        FeedBackView(
          productName: "Contact Form",
        )
      ]),
    );
  }

  Widget _viewClaimsButton(BuildContext context, String title,
      {Function action}) {
    return Center(
      child: CustomButton(
        title: title,
        width: MediaQuery.of(context).size.width / 2 + 50,
        fontSize: 12,
        paddingWidth: 10,
        height: 40,
        buttonAction: action,
      ),
    );
  }
}
