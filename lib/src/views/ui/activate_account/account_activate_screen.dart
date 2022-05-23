import 'package:ebpv2/src/router/app_routes.dart';

import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_activate_controller.dart';

class ActivateAccountScreen extends StatelessWidget {
  final AccountActivateXController controller =
      Get.put(AccountActivateXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: activationUI(),
    );
  }

  /*  ACTIVATE UI */
  Widget activationUI() {
    return SafeArea(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _thankYouTextUI(),
            addVerticalHeight(20.0),
            _thankYouSubHeadTextUI('we_have_sent_link'.tr),
            addVerticalHeight(30.0),
            _thankYouSubHeadTextUI('activate_inbox'.tr),
            addVerticalHeight(40.0),
            _activationCodeUI(),
            addVerticalHeight(40.0),
            _loginUI(),
            addVerticalHeight(10.0),
            _needHelpUI(),
          ],
        ),
      ),
    );
  }

  /*  THANK YOU HEAD TEXT */
  Widget _thankYouTextUI() {
    return label(
      'thank_you'.tr,
      textAlign: TextAlign.center,
      fontSize: 28.0,
      color: Color(0xFF707070),
    );
  }

  /*  THANK YOU SUBHEAD TEXT */
  Widget _thankYouSubHeadTextUI(String title) {
    return Container(
      child: label(
        title,
        textAlign: TextAlign.center,
        fontSize: RegularFontSize,
        color: Color(0xFF707070),
        maxLines: 2,
      ),
    );
  }

  /* ACTIVATE CODE */
  Widget _activationCodeUI() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.ACTIVATE_ACCOUNT);
                },
              text: 'resend_activation_code'.tr,
              style: textStyle(
                  MediumFontSize, FontWeight.bold, Style.MyColors.themeColor),
            ),
          ],
        ),
      ),
    );
  }

  /* ALREADY HAVE AN ACCOUNT */
  Widget _loginUI() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'already_have_an_account'.tr,
              style: textStyle(
                  MediumFontSize, FontWeight.normal, Style.MyColors.titleColor),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.LOGIN);
                },
              text: 'log_in'.tr,
              style: textStyle(
                  MediumFontSize, FontWeight.bold, Style.MyColors.themeColor),
            ),
          ],
        ),
      ),
    );
  }

  /* NEED HELP */
  Widget _needHelpUI() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.openAlertDialog();
                },
              text: 'need_help'.tr,
              style: textStyle(
                  MediumFontSize, FontWeight.bold, Style.MyColors.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}
