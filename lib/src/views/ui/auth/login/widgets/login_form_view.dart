import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_controller.dart';

class LoginFormView extends StatelessWidget {
  final LoginXController controller;

  LoginFormView({Key key, this.controller}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(
            title: 'cpr_email'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
            textController: controller.emailController,
            iconData: Icons.email,
            labelText: '',
            hintText: 'enter_cpr_email'.tr,
            validate: true,
            isEnabled: true,
            // validator: AppFormFieldValidator.emailValidator,
            onSaved: (value) {
              controller.setEmail(value);
            },
            onChanged: (value) {
              // AppFormFieldValidator.emailValidator(value);
            },
          ),
          SizedBox(
            height: 36,
          ),
          CustomLabel(
            title: 'password'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
            textController: controller.passwordController,
            focusNode: controller.passwordFocusNode,
            isObscureText: true,
            keyboardInputType: InputTypeEnum.alphanumeric,
            textInputType: TextInputType.text,
            labelText: '',
            hintText: 'enter_your_portal'.tr,
            onSaved: (value) {
              controller.setPassword(value);
            },
            onChanged: (value) {
              AppFormFieldValidator.passwordValidator(value);
            },
            validator: AppFormFieldValidator.passwordValidator,
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            child: CustomLabel(
                title: 'forgot_password'.tr,
                fontSize: 10,
                height: 1.4,
                color: Color.fromRGBO(64, 162, 190, 1),
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                underLine: true),
            onTap: () {
              Get.toNamed(AppRoutes.FORGOT_PASSWORD);
            },
          ),
          SizedBox(
            height: 34,
          ),
          Center(
            child: CustomButton(
              title: 'sign_in'.tr,
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                FocusScope.of(context).unfocus();
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  controller.submit();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
