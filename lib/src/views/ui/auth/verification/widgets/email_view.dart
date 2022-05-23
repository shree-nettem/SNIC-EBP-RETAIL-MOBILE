import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/verification/confirm_email/email_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailView extends StatelessWidget {
  final EmailVerificationXController controller =
      Get.put(EmailVerificationXController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              CustomLabel(
                title: "Enter your Email address",
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                height: 1.9,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                textController: controller.emailController,
                iconData: Icons.email,
                labelText: '',
                hintText: 'Enter your email address',
                validate: true,
                isEnabled: true,
                validator: AppFormFieldValidator.emailValidator,
                onSaved: (value) {},
                onChanged: (value) {
                  AppFormFieldValidator.emailValidator(value);
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
                      controller.verifyEMAIL();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
