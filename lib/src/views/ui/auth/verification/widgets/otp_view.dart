import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/verification/verify_otp/verify_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPView extends StatelessWidget {
  final VerifyOtpXController controller = Get.find();

  OTPView();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CustomLabel(
                  title: "Enter OTP sent to ",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.9,
                ),
              ),
              Flexible(
                child: CustomLabel(
                  title: controller.phoneNumber,
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
            hintText: 'Enter OTP',
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
              title: 'Next',
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.enablePhone("sms");
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
              title: "Didn’t receive SMS?",
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
                controller.resendOTP("sms");
              },
              child: CustomLabel(
                title: "Resend OTP",
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
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: CustomLabel(
                title: "Modify Phone Number",
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
