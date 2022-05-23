import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:ebpv2/src/views/ui/auth/verification/complete_registration/complete_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CompleteRegistrationScreen extends StatelessWidget {
  final CompleteRegistrationController controller =
      Get.put(CompleteRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
              title: "Complete Registration", isBackButtonExist: false),
          SliverFillRemaining(
            hasScrollBody: false,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return completeRegistrationView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget completeRegistrationView() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
            ),
            SizedBox(height: 32),
            CustomLabel(
              title: "Complete login credentials",
              height: 1.9,
              fontSize: 14,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            controller.existingCustomer
                ? CompleteRegistrationExistingView(controller: controller)
                : CompleteRegistrationView(controller: controller),
            Expanded(
              child: CommonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class CompleteRegistrationView extends StatelessWidget {
  final CompleteRegistrationController controller;

  const CompleteRegistrationView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.key,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            CustomLabel(
              title: "Username",
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.idNumberController,
              focusNode: null,
              iconData: Icons.email,
              labelText: '',
              isReadOnly: true,
              isDisableColored: true,
              hintText: '',
              onSaved: (value) {},
            ),
            SizedBox(
              height: 24,
            ),
            CustomLabel(
              title: "Set your password",
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.passwordController,
              focusNode: null,
              iconData: Icons.email,
              labelText: '',
              hintText: 'Enter a password',
              errorText: 'Password required',
              isObscureText: true,
              onSaved: (value) {
                controller.setPassword(value);
              },
              onChanged: (value) {
                AppFormFieldValidator.passwordValidator(value);
              },
              validator: AppFormFieldValidator.passwordValidator,
            ),
            SizedBox(height: 8),
            CustomLabel(
              title:
                  'Please ensure your password is minimum 8 characters, alphanumeric, with one capital letter and one special character.',
              maxLines: 3,
              fontSize: 11,
            ),
            SizedBox(height: 24),
            CustomLabel(
              title: "Confirm password",
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.confirmPasswordController,
              focusNode: null,
              iconData: Icons.email,
              labelText: '',
              hintText: 'Confirm password',
              errorText: 'Password is required',
              onSaved: (value) {},
              isObscureText: true,
              validator: (text) =>
                  AppFormFieldValidator.passwordConfirmValidator(
                      text, controller.passwordController.text),
            ),
            SizedBox(
              height: 32,
            ),
            Center(
              child: CustomButton(
                title: 'register'.tr,
                width: 114,
                fontSize: 12,
                height: 26,
                buttonAction: () {
                  FocusScope.of(context).unfocus();
                  if (controller.key.currentState.validate()) {
                    controller.key.currentState.save();
                    controller.registerNewUser();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompleteRegistrationExistingView extends StatelessWidget {
  final CompleteRegistrationController controller;

  const CompleteRegistrationExistingView({Key key, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: [
          CustomLabel(title: 'important_notice'.tr),
          const SizedBox(
            height: 24,
          ),
          CustomLabel(
            title: 'note_username_changed'.tr,
            maxLines: 2,
          ),
          const SizedBox(
            height: 32,
          ),
          Center(
            child: CustomButton(
              title: 'start'.tr,
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                controller.setExistedProfileAndUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}
