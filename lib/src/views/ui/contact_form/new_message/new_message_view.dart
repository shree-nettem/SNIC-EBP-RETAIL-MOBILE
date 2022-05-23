import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/contact_form/contact_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMessageView extends StatelessWidget {
  NewMessageView({Key key}) : super(key: key);

  final ContactFormXController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return Form(
            key: _controller.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLabel(
                      title: 'message_type'.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                    CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomDropDown(
                      label: _controller.messageType,
                      options: _controller.totalMessageTypes,
                      validator: AppFormFieldValidator.generalDropDownValidator,
                      onChanged: (val) {
                        AppFormFieldValidator.generalDropDownValidator(val);
                        _controller.setMessagetype(val);
                      },
                    ),
                    CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                    CustomLabel(
                      title: "message_category".tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                    CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomDropDown(
                      label: _controller.messageCategory,
                      options: _controller.totalMessageCategories,
                      validator: AppFormFieldValidator.generalDropDownValidator,
                      onChanged: (val) {
                        AppFormFieldValidator.generalDropDownValidator(val);
                        _controller.setMessageCate(val);
                      },
                    ),
                    CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                    CustomLabel(
                      title: 'message'.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                    CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    CustomTextField(
                      isTextArea: true,
                      requiredLargeTextArea: true,
                      textController: _controller.messageController,
                      labelText: '',
                      hintText: 'type_your_message'.tr,
                      validate: true,
                      isEnabled: true,
                      validator: AppFormFieldValidator.generalEmptyValidator,
                      onSaved: (value) {
                        // _dependentController.setName(value);
                      },
                      onChanged: (value) {
                        AppFormFieldValidator.generalEmptyValidator(value);
                      },
                    ),
                    CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                    Center(
                      child: CustomButton(
                        title: 'submit'.tr,
                        width: 114,
                        fontSize: 12,
                        isActive: true,
                        height: 26,
                        buttonAction: () {
                          if (_controller.formKey.currentState.validate()) {
                            _controller.postFeedback();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
