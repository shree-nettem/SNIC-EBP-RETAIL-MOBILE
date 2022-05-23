import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/forgot_password/forgot_password_controller.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordVerifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'forgot_password_title'.tr,
            isBackButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: ForgotPasswordVerifyView(),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordVerifyView extends StatelessWidget {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 60, right: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        color: MyColors.PrimaryColor,
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
                        color: MyColors.PrimaryColor,
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
                        color: Color.fromRGBO(209, 215, 219, 1),
                      ),
                    ),
                  ],
                ),
                ForgotPasswordVerifyFormView(controller: controller),
                Spacer(),
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

class ForgotPasswordVerifyFormView extends StatelessWidget {
  final ForgotPasswordController controller;
  GlobalKey<FormState> confirmFormKey = GlobalKey<FormState>();
  ForgotPasswordVerifyFormView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: confirmFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomLabel(
                title: 'enter_otp_sent'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                height: 1.9,
              ),
              CustomLabel(
                title: "",
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                height: 1.9,
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
            isOtpField: true,
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
            height: 40,
          ),
          Center(
            child: CustomButton(
              title: 'next'.tr,
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                FocusScope.of(context).unfocus();
                if (confirmFormKey.currentState.validate()) {
                  confirmFormKey.currentState.save();
                  controller
                      .validatingOTP(controller.otpController.text.trim());
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
              title: 'did_not_receive_sms'.tr,
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
                controller.forgotPasswordPhoneOTP(resendOtp: true);
                // successMessage("OTP sent successfully");
                // controller.resendOTP("sms");
              },
              child: CustomLabel(
                title: 'resend_otp'.tr,
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
