import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'review_and_adjust_controller.dart';
import 'widgets/review_and_adjust_element_type.dart';

class ReviewAndAdjustStepOne extends StatelessWidget {
  const ReviewAndAdjustStepOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ReviewAndAdjustXController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 7,
                                child: CustomLabel(
                                  title:
                                      "Review and customize your saving plan to your liking. Continue to start saving!",
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 14,
                                  maxLines: 5,
                                ),
                              ),
                              SvgPicture.asset(
                                Images.edit,
                                height: 20,
                                width: 20,
                                color: MyColors.PrimaryColor,
                              ),
                            ],
                          ),
                          CustomSpacer(
                            value: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          ReviewAndAdjustElementType("GOAL", "39,600 BHD"),
                          ReviewAndAdjustElementType("TERM", "10 years"),
                          ReviewAndAdjustElementType("STRATEGY", "Moderate"),
                          ReviewAndAdjustElementType("CONTRIBUTION", "249 BHD"),
                          ReviewAndAdjustElementType("FREQUENCY", "3Monthly"),
                          ReviewAndAdjustElementType("LUMPSUM", "0 BHD"),
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
            ),
          );
        });
  }
}
