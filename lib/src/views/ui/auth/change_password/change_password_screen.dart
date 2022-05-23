import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/change_password/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordXController controller =
      Get.put(ChangePasswordXController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: MyColors.MainColor,
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(title: 'change_password'.tr),
              SliverFillRemaining(
                hasScrollBody: false,
                child: ChangePasswordView(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangePasswordView extends StatelessWidget {
  final ChangePasswordXController controller;

  const ChangePasswordView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
            right: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              CustomLabel(
                title: 'enter_current_password'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                textController: controller.currentPasswordController,
                labelText: '',
                hintText: 'enter_current_password'.tr,
                validate: true,
                isEnabled: true,
                isObscureText: true,
                validator: AppFormFieldValidator.passwordValidator,
                onSaved: (value) {},
                onChanged: (value) {
                  AppFormFieldValidator.passwordValidator(value);
                },
              ),
              SizedBox(
                height: 32,
              ),
              CustomLabel(
                title: 'enter_new_password'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                textController: controller.newPasswordController,
                labelText: '',
                hintText: 'enter_new_password'.tr,
                validate: true,
                isEnabled: true,
                isObscureText: true,
                validator: AppFormFieldValidator.passwordValidator,
                onSaved: (value) {},
                onChanged: (value) {
                  AppFormFieldValidator.passwordValidator(value);
                },
              ),
              SizedBox(
                height: 8,
              ),
              CustomLabel(
                title: 'ensure_your_password'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 11,
                height: 1.5,
                maxLines: 3,
              ),
              SizedBox(
                height: 32,
              ),
              CustomLabel(
                title: 'confirm_new_password'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                textController: controller.confirmPasswordController,
                labelText: '',
                hintText: 'confirm_new_password'.tr,
                validate: true,
                isObscureText: true,
                isEnabled: true,
                onSaved: (value) {},
                validator: AppFormFieldValidator.passwordValidator,
                onChanged: (text) =>
                    AppFormFieldValidator.passwordConfirmValidator(
                        text, controller.newPasswordController.text),
              ),
              SizedBox(
                height: 40,
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
                      controller.changePassword();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
