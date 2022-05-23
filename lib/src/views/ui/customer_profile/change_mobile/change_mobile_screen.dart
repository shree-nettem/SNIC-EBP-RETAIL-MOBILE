import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_international_phone_validate.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:ebpv2/src/views/ui/customer_profile/change_mobile/change_mobile_controller..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../verify_password/verify_password_controller..dart';

class ChangeMobileScreen extends StatelessWidget {
  final ChangeMobileXController controller = Get.put(ChangeMobileXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'change_mobile'.tr,
            isBackButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return changeEmailView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget changeEmailView() {
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
            ConfirmEmailView(controller: controller),
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

class ConfirmEmailView extends StatelessWidget {
  final ChangeMobileXController controller;

  const ConfirmEmailView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyPasswordController vController =
        Get.put(VerifyPasswordController());
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
              title: 'enter_new_mobile'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              height: 1.9,
            ),
            SizedBox(
              height: 12,
            ),
            CustomInternationalPhoneValidate(
              initialPhoneNumber: controller.number,
              phoneController: controller.mobileController,
              hintText: 'enter_phone'.tr,
              onSaved: (value) {
                controller.setMobile(value);
              },
              onChange: (String v) {
                vController.updateRequester(v);
              },
              dailCode: (val) {
                controller.updatedCountryCode(val);
                //  vController.updateDialCode(val);
                print(val);
              },
            ),
            Obx(
              () => vController.otpEntered.value
                  ? const Offstage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
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
                              vController.requestOTP();
                            },
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: 32,
            ),
            Obx(
              () => vController.otpEntered.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabel(
                          title: 'enter_otp'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          height: 1.9,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          textController: controller.otpController,
                          labelText: '',
                          keyboardInputType: InputTypeEnum.numeric,
                          textInputType: TextInputType.number,
                          hintText: 'enter_otp'.tr,
                          onChanged: (value) {
                            AppFormFieldValidator.otpValidator(value);
                          },
                          validator: AppFormFieldValidator.otpValidator,
                          onSaved: (value) {
                            controller.setOTP(value);
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
                                controller.changeMobile();
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : const Offstage(),
            ),
          ],
        ),
      ),
    );
  }
}
