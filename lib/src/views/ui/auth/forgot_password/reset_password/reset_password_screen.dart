import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/forgot_password/reset_password/reset_password_controller.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'reset_password'.tr,
            isBackButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: resetPasswordView(),
          ),
        ],
      ),
    );
  }

  Widget resetPasswordView() {
    return GetBuilder(
      init: controller,
      builder: (_) {
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
                            shape: BoxShape.circle,
                            color: MyColors.PrimaryColor),
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
                CompleteRegistrationView(controller: controller),
                Expanded(
                  child: CommonWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CompleteRegistrationView extends StatelessWidget {
  final ResetPasswordController controller;

  const CompleteRegistrationView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            CustomLabel(
              title: 'user_name'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.cprController,
              focusNode: null,
              iconData: Icons.email,
              labelText: '',
              textInputType: TextInputType.text,
              hintText: '9512009213',
              validate: true,
              isEnabled: true,
              onSaved: (value) {},
              validator: AppFormFieldValidator.cprValidator,
              onChanged: (value) {
                AppFormFieldValidator.cprValidator(value);
              },
            ),
            SizedBox(
              height: 24,
            ),
            CustomLabel(
              title: 'set_your_password'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.passwordController,
              labelText: '',
              isObscureText: true,
              validate: true,
              isEnabled: true,
              hintText: 'enter_a_password'.tr,
              onSaved: (value) {},
              validator: AppFormFieldValidator.passwordValidator,
              onChanged: (value) {
                AppFormFieldValidator.passwordValidator(value);
              },
            ),
            SizedBox(height: 8),
            CustomLabel(
              title: 'password_hint'.tr,
              maxLines: 3,
              fontSize: 11,
            ),
            SizedBox(height: 24),
            CustomLabel(
              title: 'confirm_password'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.confirmPasswordController,
              labelText: '',
              isObscureText: true,
              validate: true,
              isEnabled: true,
              hintText: 'enter_a_confirm_password'.tr,
              onSaved: (value) {},
              validator: (String v) {
                return AppFormFieldValidator.passwordConfirmValidator(
                    v, controller.passwordController.text);
              },
              onChanged: (text) =>
                  AppFormFieldValidator.passwordConfirmValidator(
                      text, controller.passwordController.text),
            ),
            SizedBox(
              height: 32,
            ),
            Center(
              child: CustomButton(
                title: 'done'.tr,
                width: 114,
                fontSize: 12,
                height: 26,
                buttonAction: () {
                  FocusScope.of(context).unfocus();
                  if (controller.formKey.currentState.validate()) {
                    controller.formKey.currentState.save();
                    controller.resetPassword();
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
