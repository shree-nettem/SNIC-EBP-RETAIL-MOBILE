import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/ghady_set_your_goal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GhadySetYourGoalStepThree extends StatelessWidget {
  const GhadySetYourGoalStepThree({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: GhadySetYourGoalXController(),
        builder: (_) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 2,
                    color: MyColors.themeColor,
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
                            title: 'planToRetireByFifty'.tr,
                            maxLines: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontSize: 12.0),
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
                            title: 'basedOnInfoRetirement'.tr,
                            maxLines: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontSize: 14.0)
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
                    child: CustomButton(
                      title: 'Confirm',
                      width: 114,
                      fontSize: 12,
                      height: 26,
                      buttonAction: () {},
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

// step 3 completionView in set your goal flow

class SetYourGoalCompletionView extends StatelessWidget {
  SetYourGoalCompletionView({Key key}) : super(key: key);
  final GhadySetYourGoalXController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
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
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "I want to save for ",
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontSize: 14,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              decoration: TextDecoration.none),
                        ),
                        TextSpan(
                          text: 'Retirement',
                          style: TextStyle(
                            color: Color.fromRGBO(64, 162, 190, 1),
                            fontSize: 14,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "My goal is to save ",
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontSize: 14,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              decoration: TextDecoration.none),
                        ),
                        TextSpan(
                          text: "BHD " +
                              _controller.existedRetirmentData.inputs.target
                                  .toString(),
                          style: TextStyle(
                            color: Color.fromRGBO(64, 162, 190, 1),
                            fontSize: 14,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                        ),
                        TextSpan(
                          text: " in ",
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontSize: 14,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              decoration: TextDecoration.none),
                        ),
                        TextSpan(
                          text:
                              '${_controller.existedRetirmentData.inputs.terms.toString()} years ',
                          style: TextStyle(
                            color: Color.fromRGBO(64, 162, 190, 1),
                            fontSize: 14,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                        ),
                        TextSpan(
                          text: "to reach my retirement goals.",
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontSize: 14,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                  ),
                  CustomSpacer(
                    value: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  SvgPicture.asset(
                    Images.edit,
                    height: 20,
                    width: 20,
                    color: MyColors.GrayColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
