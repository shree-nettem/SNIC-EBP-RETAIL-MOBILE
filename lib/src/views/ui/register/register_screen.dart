
import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/register/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterXController controller = Get.put(RegisterXController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF000F5F).withOpacity(0.9),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Style.MyColors.MainColor,
        resizeToAvoidBottomInset: true,
        body: GetBuilder(
          init: controller,
          builder: (_) {
            return registerUI();
          },
        ),
      ),
    );
  }

  /* REGISTER UI  */
  Widget registerUI() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _registerTextUI(),
                addVerticalHeight(20.0),
                _registerFormUI(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* APP TITLE */
  Widget _registerTextUI() {
    return Container(
      child: new Column(
        children: <Widget>[
          new Wrap(
            children: <Widget>[
              new Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Column(
                    children: [
                      label("Employee Benefits Platform",
                          textAlign: TextAlign.center,
                          fontSize: 28.0,
                          color: Colors.black54,
                          maxLines: 2),
                      addVerticalHeight(15),
                      label("Registration",
                          textAlign: TextAlign.center,
                          fontSize: RegularFontSize,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _registerFormUI() {
    return Column(
      children: [
        textField(
          textController: controller.emailController,
          focusNode: controller.emailFocusNode,
          iconData: Icons.email,
          textInputType: TextInputType.emailAddress,
          labelText: 'Corporate Email',
          hintText: 'Enter Email',
          errorText: 'Corporate E-mail is required',
          validate: controller.validate['email'],
          onChanged: (value) {
            controller.updateRegisterEmailValidation();
          },
        ),
        _segmentButtonUI(),
        textField(
          textController: controller.idNumberController,
          focusNode: controller.idNumberFocusNode,
          iconData: Icons.confirmation_number,
          textInputType: TextInputType.text,
          labelText: 'ID Number (required)',
          hintText: 'ID Number (required)',
          errorText: controller.segmentErrorMessage,
          validate: controller.validate['id_number'],
          onChanged: (value) {
            controller.updateRegisterIDValidation();
          },
        ),
        textField(
          textController: controller.passwordController,
          focusNode: controller.passwordFocusNode,
          iconData: Icons.lock,
          isObscureText: true,
          labelText: 'Password',
          hintText: 'Enter Password',
          errorText: 'Password is required',
          validate: controller.validate['password'],
          onChanged: (value) {
            controller.updateRegisterPasswordValidation();
          },
        ),
        addVerticalHeight(10),
        _agreeUI(),
        _termsErrorUI(),
        addVerticalHeight(10),
        _buildRegister(),
        addVerticalHeight(40),
        _loginUI(),
        addVerticalHeight(10),
        _needHelpUI(),
      ],
    );
  }

  /* SEGMENT BUTTON UI */
  Widget _segmentButtonUI() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: controller.identityType,
        selectionIndex: controller.currentSelection,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          controller.setSegmentState(index);
        },
      ),
    );
  }

  /* FORGOT YOUR AGREE */
  Widget _agreeUI() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: Style.MyColors.themeColor,
              value: controller.agreed,
              onChanged: (bool value) {
                controller.termsAgreed(value);
              },
            ),
            Text(
              'I agree on the',
              style: textStyle(
                  SmallFontSize, FontWeight.normal, Style.MyColors.titleColor),
            ),
            Text(
              ' terms & conditions',
              style: textStyle(
                  SmallFontSize, FontWeight.normal, Style.MyColors.themeColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _termsErrorUI() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 15.0, 10.0),
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Visibility(
          child: Text(
            'You must agree on the terms and conditions',
            style: textStyle(SmallFontSize, FontWeight.normal, Colors.red),
          ),
          visible: controller.isVisible,
        ),
      ),
    );
  }

  /* REGISTER BUTTON */
  Widget _buildRegister() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: button(
            'Sign Up',
            () => controller.submit(),
            isRounded: true,
          ),
        ),
      ),
    );
  }

  /* ALREADY HAVE AN ACCOUNT */
  Widget _loginUI() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Already have an account?",
            style: textStyle(
                MediumFontSize, FontWeight.normal, Style.MyColors.titleColor),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
               // Get.toNamed(AppRoutes.LOGIN);
                Get.back();
              },
            text: ' Log In',
            style: textStyle(
                MediumFontSize, FontWeight.bold, Style.MyColors.themeColor),
          ),
        ],
      ),
    );
  }

  /* NEED HELP */
  Widget _needHelpUI() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                controller.openAlertDialog();
              },
            text: "Need Help?",
            style: textStyle(
                MediumFontSize, FontWeight.bold, Style.MyColors.themeColor),
          ),
        ],
      ),
    );
  }
}
