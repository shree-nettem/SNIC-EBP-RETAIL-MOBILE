import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/auth/forgot_password/forgot_password_controller.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/custom_international_phone_validate.dart';

class ForgotPasswordScreen extends StatelessWidget {
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
            child: ForgotPasswordView(),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 60, right: 60),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
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
            ForgotPasswordFormView(),
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

class ForgotPasswordFormView extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller =
        Get.put(ForgotPasswordController());
    print("number ${controller.phoneController.text}");
    return GetBuilder(
      initState: (state) => controller.onInit(),
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
                title: 'enter_mobile_number'.tr,
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
                },
                dailCode: (val) {
                  controller.updatedCountryCode(val);
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
                    if (formKey.currentState.validate()) {
                      // formKey.currentState.save();
                      if (controller.phoneController.text.length > 3) {
                        controller.forgotPasswordPhoneOTP();
                      } else {
                        successMessage("Please enter valid mobile number");
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
