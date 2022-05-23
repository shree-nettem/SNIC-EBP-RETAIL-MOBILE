import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/select_your_strategy/select_your_strategy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectYourStrategyStepOne extends StatelessWidget {
  SelectYourStrategyStepOne({Key key}) : super(key: key);
  final SelectYourStrategyXController _controller =
      Get.put(SelectYourStrategyXController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 225,
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
                        CustomRadioButton(
                          text: 'cautious'.tr,
                          subText: 'cautiousSubtext'.tr,
                          value: _controller.isBrandNew[0],
                          onTap: () {
                            _controller.updateRadioButton(0);
                          },
                        ),
                        CustomRadioButton(
                          text: 'moderate'.tr,
                          subText: 'moderateSubtext'.tr,
                          value: _controller.isBrandNew[1],
                          onTap: () {
                            _controller.updateRadioButton(1);
                          },
                        ),
                        CustomRadioButton(
                          text: 'adventurous'.tr,
                          subText: 'adventurousSubtext'.tr,
                          value: _controller.isBrandNew[2],
                          onTap: () {
                            _controller.updateRadioButton(2);
                          },
                        ),
                        CustomRadioButton(
                          text: 'notSure'.tr,
                          subText: 'notSureSubtext'.tr,
                          value: _controller.isBrandNew[3],
                          onTap: () {
                            _controller.updateRadioButton(3);
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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

// step 2 of select your strategy view

class SelectYourStrategyStepTwo extends StatelessWidget {
  const SelectYourStrategyStepTwo({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SelectYourStrategyXController(),
        builder: (_controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 225,
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
                            title:
                                "We're going to ask few questions to determine the strategy bbest suited of you. \n\n 1.Which do you prefer",
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontSize: 12,
                            maxLines: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRadioButton(
                            text: "Being a salaried employee",
                            value: _controller.isBrandNew[0],
                            onTap: () {
                              _controller.updateRadioButton(0);
                            },
                          ),
                          CustomRadioButton(
                            text:
                                "Being a salaried employee and having side business",
                            value: _controller.isBrandNew[1],
                            onTap: () {
                              _controller.updateRadioButton(1);
                            },
                          ),
                          CustomRadioButton(
                            text: "Ruing a partnership business",
                            value: _controller.isBrandNew[2],
                            onTap: () {
                              _controller.updateRadioButton(2);
                            },
                          ),
                          CustomRadioButton(
                            text: "Running your own business",
                            value: _controller.isBrandNew[3],
                            onTap: () {
                              _controller.updateRadioButton(3);
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
                      onTap: () {},
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
            ),
          );
        });
  }
}

// step 3 of select your strategy view

class SelectYourStrategyStepThree extends StatelessWidget {
  const SelectYourStrategyStepThree({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SelectYourStrategyXController(),
      builder: (_controller) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 175,
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
                        title: 'recommended_strategy'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontSize: 12,
                        maxLines: 5,
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      ),
                      CustomLabel(
                        title: 'moderate_strategy'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        color: MyColors.VerticalDividerColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 18,
                        maxLines: 5,
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      CustomLabel(
                        title: 'reducing_risks_enhance'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontSize: 12,
                        maxLines: 10,
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
                  onTap: () {},
                  child: CustomBackNextutton(
                    isBackButton: true,
                  ),
                ),
                CustomButton(
                  title: 'confirm'.tr,
                  width: 114,
                  fontSize: 12,
                  height: 26,
                  buttonAction: () {},
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}

class SelectYourStrategyCompletionStep extends StatelessWidget {
  const SelectYourStrategyCompletionStep({Key key}) : super(key: key);

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
                          text: 'my_startegy_to_reach'.tr,
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontSize: 12,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              decoration: TextDecoration.none),
                        ),
                        TextSpan(
                          text: 'moderate'.tr,
                          style: TextStyle(
                            color: Color.fromRGBO(64, 162, 190, 1),
                            fontSize: 12,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSpacer(
                    value: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  CustomLabel(
                    title: 'reducing_risks_enhancing'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 12,
                    maxLines: 5,
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
