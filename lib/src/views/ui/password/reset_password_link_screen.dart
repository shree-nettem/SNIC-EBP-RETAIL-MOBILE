import 'package:ebpv2/src/router/app_routes.dart';

import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/activate_account/account_activate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordLinkScreen extends StatelessWidget {
  static final pageId = "/resentPasswordLinkScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: resetPasswordUI(),
    );
  }

  /*  ACTIVATE UI */
  Widget resetPasswordUI() {
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
            _thankYouSubHeadTextUI("We have sent you a password reset link."),
            addVerticalHeight(30.0),
            _thankYouSubHeadTextUI(
                "Kindly check your inbox to reset your password."),
            addVerticalHeight(40.0),
            _didNotReceiveUI(),
            addVerticalHeight(10.0),
            _activationCodeUI(),
            addVerticalHeight(50.0),
            _loginUI(),
            addVerticalHeight(10.0),
          ],
        ),
      ),
    );
  }

  // THANK YOU HEAD TEXT
  Widget _thankYouTextUI() {
    return label(
      "Thank You,",
      textAlign: TextAlign.center,
      fontSize: 28.0,
      color: Color(0xFF707070),
    );
  }

  // THANK YOU SUBHEAD TEXT
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

  Widget _didNotReceiveUI() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Did not receive it yet?",
          style: textStyle(
              MediumFontSize, FontWeight.normal, Style.MyColors.titleColor),
        ),
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
              text: "Resend Password Reset Link!",
              style: textStyle(
                  MediumFontSize, FontWeight.normal, Style.MyColors.themeColor),
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
              text: "Already know your password?",
              style: textStyle(
                  MediumFontSize, FontWeight.normal, Style.MyColors.titleColor),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.offAllNamed(AppRoutes.LOGIN);
                },
              text: ' Log In',
              style: textStyle(
                  MediumFontSize, FontWeight.bold, Style.MyColors.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}
