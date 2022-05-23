import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';

class PaymentSuccessScreen extends StatelessWidget {
  PaymentXController controller = Get.put(PaymentXController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'motorInsurance'.tr,
            info: "motor_innsurance_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: controller,
                builder: (_) {
                  return _motoInsuranceUI(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _motoInsuranceUI(BuildContext context) {
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
            title: 'congratulations'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomLabel(
            title: "Ref number: #21341234",
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomLabel(
            title: 'paymentSuccessMSG'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: CustomLabel(
            title: "Plan is valid through 21/3/2022",
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: RichText(
                text: new TextSpan(children: [
              TextSpan(
                  text: 'youCanNow'.tr + " ",
                  style: TextStyle(
                    color: MyColors.PrimaryColor,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  )),
              TextSpan(
                  text: 'renew'.tr,
                  style: TextStyle(
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.PrimaryColor,
                    decoration: TextDecoration.underline,
                  )),
            ]))),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 35, bottom: 15, left: 10.0),
          child: CustomLabel(
            title: 'downloadDocuments'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w500,
            color: MyColors.PrimaryColor,
            fontSize: 14,
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 3,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    child: downloadDocument(index: index, context: context),
                  ),
                );
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                title: 'viewall'.tr,
                width: 122,
                height: 26,
                fontSize: 12,
                buttonAction: () {
                  // controller.setPlanSelected();
                  //motorXController.expansionCardKey[1].currentState.collapse();
                },
              ),
              SizedBox(
                width: 10,
              ),
              CustomButton(
                title: 'downloadall'.tr,
                width: 122,
                height: 26,
                fontSize: 12,
                buttonAction: () {
                  // controller.setPlanSelected();
                  //motorXController.expansionCardKey[1].currentState.collapse();
                },
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 40, bottom: 30),
            child: FeedBackView(
              productName: "Motor New Business",
            )),
      ]),
    );
  }

  downloadDocument({int index, BuildContext context}) {
    return Row(
      children: [
        CustomLabel(
          title: 'policySchedule'.tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.all(20),
          child: SvgPicture.asset(
            Images.view,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: SvgPicture.asset(
            Images.downlaod,
          ),
        ),
      ],
    );
  }
}
