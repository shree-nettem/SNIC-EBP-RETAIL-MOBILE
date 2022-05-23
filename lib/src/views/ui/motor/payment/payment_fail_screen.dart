import 'dart:io';

import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/home/home_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/feedback.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utilities/colors.dart';

class PaymentFailedScreen extends StatelessWidget {
  PaymentXController controller = Get.put(PaymentXController());
  HomeXController homeController = Get.find();

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
          margin: EdgeInsets.only(top: 50, bottom: 10),
          child: SvgPicture.asset(
            Images.payment_failed,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: CustomLabel(
            title: 'failed_Payment'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 50),
            child: RichText(
                textAlign: TextAlign.center,
                text: new TextSpan(children: [
                  TextSpan(
                      text: 'somethingWentWrong'.tr + '. ',
                      style: TextStyle(
                        color: MyColors.PrimaryColor,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (Platform.isAndroid) {
                            // add the [https]
                            launch(
                                "https://wa.me/${homeController.contactInfo.whatsAppNumber.toString()}"); // new line
                          } else {
                            // add the [https]
                            launch(
                                "https://api.whatsapp.com/send?phone=${homeController.contactInfo.whatsAppNumber.toString()}"); // new line
                          }
                        },
                      text: 'contactUs'.tr,
                      style: TextStyle(
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: MyColors.PrimaryColor,
                        decoration: TextDecoration.underline,
                      )),
                ]))),
        Container(
          margin: EdgeInsets.only(top: 60),
          child: CustomButton(
            title: 'tryAgain'.tr,
            width: 250,
            height: 40,
            fontSize: 12,
            buttonAction: () {
              Get.back();
            },
          ),
        ),
      ]),
    );
  }
}
