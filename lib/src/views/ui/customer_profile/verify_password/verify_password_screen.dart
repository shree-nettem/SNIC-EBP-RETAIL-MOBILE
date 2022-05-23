import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:ebpv2/src/views/ui/customer_profile/verify_password/verify_password_controller..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPasswordScreen extends StatelessWidget {
  final VerifyPasswordController controller =
      Get.put(VerifyPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'enter_password'.tr,
            isBackButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return passwordView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordView() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 60, right: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    color: Color.fromRGBO(209, 215, 219, 1),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromRGBO(209, 215, 219, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(209, 215, 219, 1),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromRGBO(209, 215, 219, 1),
                    ),
                  ),
                ),
              ],
            ),
            VerifyPasswordFormView(controller: controller),
            Spacer(),
            Expanded(
              child: CommonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyPasswordFormView extends StatelessWidget {
  final VerifyPasswordController controller;

  const VerifyPasswordFormView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
            ),
            CustomLabel(
              title: 'confirm_password'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              height: 1.9,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextField(
              textController: controller.passwordController,
              labelText: '',
              isObscureText: true,
              keyboardInputType: InputTypeEnum.alphanumeric,
              textInputType: TextInputType.text,
              hintText: 'enter_password'.tr,
              onChanged: (value) {
                AppFormFieldValidator.passwordValidator(value);
              },
              validator: AppFormFieldValidator.passwordValidator,
              onSaved: (value) {
                controller.setPassword(value);
              },
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: CustomButton(
                title: 'next'.tr,
                width: 114,
                fontSize: 12,
                height: 26,
                bgColor: MyColors.PrimaryColor,
                buttonAction: () {
                  FocusScope.of(context).unfocus();
                  if (controller.formKey.currentState.validate()) {
                    controller.formKey.currentState.save();
                    controller.verifyPassword();
                  }
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.CHANGE_PASSWORD);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLabel(
                    title: 'forgot_password'.tr,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
