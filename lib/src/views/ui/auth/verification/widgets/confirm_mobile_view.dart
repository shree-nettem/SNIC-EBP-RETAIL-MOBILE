import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_international_phone_validate.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/auth/verification/confirm_phone/phone_verification_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class ConfirmMobileView extends StatelessWidget {
  final PhoneVerificationXController controller =
      Get.put(PhoneVerificationXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              CustomLabel(
                title: 'confirm_phone_number'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                height: 1.9,
              ),
              SizedBox(
                height: 12,
              ),
              CustomInternationalPhoneValidate(
                initialPhoneNumber: controller.number,
                phoneController: controller.phoneController,
                onSaved: (value) {
                  controller.setPhoneNumber(value);
                  controller.isEnabled();
                },
                dailCode: (val) {
                  controller.updatedCountryCode(val);
                },
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  GFCheckbox(
                    size: 18,
                    type: GFCheckboxType.basic,
                    inactiveBorderColor: Color.fromRGBO(209, 215, 219, 1),
                    activeBgColor: MyColors.PrimaryColor,
                    activeIcon: Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      controller.onTermsChecked();
                    },
                    value: controller.isChecked,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "I accept the  ",
                            style: TextStyle(
                                color: MyColors.PrimaryColor,
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                height: 1.4,
                                decoration: TextDecoration.none),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.TERMS);
                              },
                            text: 'terms and conditions ',
                            style: TextStyle(
                                color: Color.fromRGBO(64, 162, 190, 1),
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                height: 1.4,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  GFCheckbox(
                    size: 18,
                    type: GFCheckboxType.basic,
                    inactiveBorderColor: Color.fromRGBO(209, 215, 219, 1),
                    activeIcon: Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    ),
                    activeBgColor: MyColors.PrimaryColor,
                    onChanged: (value) {
                      controller.agreeMyInformation();
                    },
                    value: controller.isMyInformationChecked,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'agree_to_share'.tr,
                            style: TextStyle(
                                color: MyColors.PrimaryColor,
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                height: 1.4,
                                decoration: TextDecoration.none),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.PRIVACY_POLICY);
                              },
                            text: 'privacy_policy'.tr,
                            style: TextStyle(
                                color: Color.fromRGBO(64, 162, 190, 1),
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                height: 1.4,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                  bgColor: !controller.disabled
                      ? MyColors.PrimaryColor
                      : MyColors.disableGreyColor,
                  isActive: controller.disabled ? false : true,
                  buttonAction: () {
                    FocusScope.of(context).unfocus();
                    if (controller.formKey.currentState.validate()) {
                      controller.formKey.currentState.save();
                      if (!controller.disabled) {
                        controller.verifyPhone();
                      } else {
                        null;
                      }
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
