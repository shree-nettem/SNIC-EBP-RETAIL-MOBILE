import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/verification/confirm_email/email_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmailVerifiedView extends StatelessWidget {
  final EmailVerificationXController controller;

  const EmailVerifiedView({this.controller});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 78,
          ),
          SvgPicture.asset(
            Images.check_circle,
            height: 43,
            width: 43,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          CustomLabel(
            title: "Email Verified",
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            textAlign: TextAlign.center,
            fontSize: 16,
            height: 2.1,
          ),
          SizedBox(
            height: 36,
          ),
          Divider(
            height: 1,
            color: Color.fromRGBO(209, 215, 219, 1),
          ),
          SizedBox(
            height: 36,
          ),
          CustomLabel(
            title: "Have a friend referral code or QR",
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            textAlign: TextAlign.center,
            fontSize: 14,
            height: 1.9,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
            iconData: Icons.email,
            labelText: '',
            textController: controller.referralCodeController,
            hintText: 'Enter promo code',
            errorText: 'Corporate E-mail is required',
            isSuffix: true,
            keyboardInputType: InputTypeEnum.alphaDigits,
            image: Images.confirm_scan,
            restrictSpecialCharecter: true,
            validator: (value) {
              return AppFormFieldValidator.generalEmptyValidator(value,
                  errorText: "Referral code is required");
            },
            onChanged: (value) {
              AppFormFieldValidator.generalEmptyValidator(value,
                  errorText: "Referral code is required");
            },
            onSuffixIconTap: () {
              _showPicker();
            },
          ),
          SizedBox(
            height: 36,
          ),
          Center(
            child: CustomButton(
              title: 'next'.tr,
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                /* WITH REFERRAL CODE */
                if (formKey.currentState.validate()) {
                  controller.verifyReferralCode();
                 
                }
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Center(
            child: CustomButton(
              title: 'Skip',
              width: 114,
              fontSize: 12,
              height: 26,
              buttonAction: () {
                /* WITHOUT REFERRAL CODE */
                Get.toNamed(AppRoutes.IDENTITY_VERIFICATION_REQUIRED,
                    arguments: {
                      "referral_code": "",
                      "id": controller.userId,
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker() {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: CustomLabel(title: "documents".tr, fontSize: 14),
                  onTap: () {
                    controller.getImageGallery();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: CustomLabel(title: "camera".tr, fontSize: 14),
                  onTap: () {
                    controller.scanQRCode();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
