import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'review_and_adjust_controller.dart';

class EditReviewAndPreviewView extends StatelessWidget {
  const EditReviewAndPreviewView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ReviewAndAdjustXController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: 2,
                    color: MyColors.VerticalDividerColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title:
                              "Review and customize your saving plan to your liking. Continue to start saving!",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 5,
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: "Goal",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectLumpsAmount'.tr,
                          validate: true,
                          isEnabled: true,
                          validator:
                              AppFormFieldValidator.generalEmptyValidator,
                          onSaved: (value) {
                            //controller.setEmail(value);
                          },
                          onChanged: (value) {
                            AppFormFieldValidator.generalEmptyValidator(value);
                          },
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: "Goal",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectLumpsAmount'.tr,
                          validate: true,
                          isEnabled: true,
                          validator:
                              AppFormFieldValidator.generalEmptyValidator,
                          onSaved: (value) {
                            //controller.setEmail(value);
                          },
                          onChanged: (value) {
                            AppFormFieldValidator.generalEmptyValidator(value);
                          },
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: "Goal",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectLumpsAmount'.tr,
                          validate: true,
                          isEnabled: true,
                          validator:
                              AppFormFieldValidator.generalEmptyValidator,
                          onSaved: (value) {
                            //controller.setEmail(value);
                          },
                          onChanged: (value) {
                            AppFormFieldValidator.generalEmptyValidator(value);
                          },
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: "Goal",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectLumpsAmount'.tr,
                          validate: true,
                          isEnabled: true,
                          validator:
                              AppFormFieldValidator.generalEmptyValidator,
                          onSaved: (value) {
                            //controller.setEmail(value);
                          },
                          onChanged: (value) {
                            AppFormFieldValidator.generalEmptyValidator(value);
                          },
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: "Goal",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectLumpsAmount'.tr,
                          validate: true,
                          isEnabled: true,
                          validator:
                              AppFormFieldValidator.generalEmptyValidator,
                          onSaved: (value) {
                            //controller.setEmail(value);
                          },
                          onChanged: (value) {
                            AppFormFieldValidator.generalEmptyValidator(value);
                          },
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: "Goal",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectLumpsAmount'.tr,
                          validate: true,
                          isEnabled: true,
                          validator:
                              AppFormFieldValidator.generalEmptyValidator,
                          onSaved: (value) {
                            //controller.setEmail(value);
                          },
                          onChanged: (value) {
                            AppFormFieldValidator.generalEmptyValidator(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // _subbmitController.formKey.currentState.collapse();
                    },
                    child: CustomBackNextutton(
                      isBackButton: true,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: CustomBackNextutton(
                      isBackButton: false,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }
}
