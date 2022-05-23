import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/ghady_set_your_goal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetYourGoalStepTwoView extends StatelessWidget {
  const SetYourGoalStepTwoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: GhadySetYourGoalXController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 2,
                    color: MyColors.PrimaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabel(
                          title: 'iWantToSaveFor'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ClipOval(
                              child: Container(
                                height: 15,
                                width: 15,
                                color: MyColors.PrimaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomLabel(
                                title: 'retirment'.tr,
                                color: MyColors.PrimaryColor,
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontWeight: FontWeight.w700)
                          ],
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT / 2,
                        ),
                        Divider(
                          thickness: 1.5,
                          color: MyColors.GrayColor,
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT / 2,
                        ),
                        CustomLabel(
                          title: 'planToRetireByAge'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                          label: controller.makeYear.value,
                          options: controller.retireAge,
                          validator:
                              AppFormFieldValidator.generalDropDownValidator,
                          onChanged: (val) {
                            controller.makeYear.value = val;
                            AppFormFieldValidator.generalDropDownValidator(val);
                          },
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        CustomLabel(
                          title: 'desiredIncome'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          // textController: controller.motorValue,
                          textInputType: TextInputType.number,
                          labelText: '',
                          hintText: 'selectDesiredAmount'.tr,
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
                          title: 'depositeThisAmount'.tr,
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
                    onTap: () {
                      // if (_controller.formKey.currentState.validate()) {
                      //   if (_controller.treatmentDateController.text !=
                      //       "") {
                      //     _controller.saveProfileData();
                      //   }
                      // }
                    },
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
