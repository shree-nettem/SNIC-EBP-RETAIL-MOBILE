import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/verification/confirm_email/email_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class ConfirmEmailAddressView extends StatelessWidget {
  final EmailVerificationXController controller;

  const ConfirmEmailAddressView({this.controller});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32,
          ),
          InkWell(
            onTap: () {
              // controller.onNext(4);
            },
            child: CustomLabel(
              title: 'confirm_email'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              height: 1.9,
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CustomLabel(
                  title: 'enter_otp_sent'.tr,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.9,
                ),
              ),
              Flexible(
                child: CustomLabel(
                  title: controller.emailController.text,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.9,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
            textController: controller.otpController,
            labelText: '',
            textInputType: TextInputType.number,
            hintText: 'enter_otp'.tr,
            validate: true,
            isEnabled: true,
            onSaved: (value) {},
            validator: AppFormFieldValidator.otpValidator,
            onChanged: (value) {
              AppFormFieldValidator.otpValidator(value);
            },
          ),
          SizedBox(
            height: 38,
          ),
          Center(
            child: CustomButton(
              title: 'next'.tr,
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                FocusScope.of(context).unfocus();
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  controller.enableEmail("email");
                }
              },
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Divider(
            height: 1,
            color: Color.fromRGBO(209, 215, 219, 1),
          ),
          SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.center,
            child: CustomLabel(
              title: 'did_not_receive_email'.tr,
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                controller.resendOTP("email");
              },
              child: CustomLabel(
                title: 'resend_email'.tr,
                fontSize: 12,
                textAlign: TextAlign.center,
                underLine: true,
                color: Color.fromRGBO(64, 162, 190, 1),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {
              controller.modifyPhoneNumber();
            },
            child: Align(
              alignment: Alignment.center,
              child: CustomLabel(
                title: 'modify_email_address'.tr,
                fontSize: 12,
                textAlign: TextAlign.center,
                underLine: true,
                color: Color.fromRGBO(64, 162, 190, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
