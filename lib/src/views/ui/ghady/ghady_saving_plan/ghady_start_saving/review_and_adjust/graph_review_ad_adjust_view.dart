import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/review_and_adjust/widgets/review_graph_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'widgets/review_and_adjust_element_type.dart';

class ReviewAndAdjustEditStepTwo extends StatelessWidget {
  const ReviewAndAdjustEditStepTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabel(
                  title: "Investment growth",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  maxLines: 2,
                ),
                CustomLabel(
                  title: "Year 1",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 14,
                  // fontWeight: FontWeight.w600,
                  maxLines: 2,
                ),
                ReviewGraphView(),
                Container(
                  width: double.maxFinite,
                  child: CupertinoSlider(
                    value: 10,
                    min: 0.0,
                    max: 100.0,
                    divisions: 1,
                    activeColor: MyColors.PrimaryColor,
                    thumbColor: MyColors.PrimaryColor,
                    onChanged: (double value) {},
                  ),
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                CustomLabel(
                  title: "Slide to show yearly investment growth",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 14,
                  color: MyColors.GrayColor,
                  maxLines: 2,
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                YearlyGrowthElementType("GOAL", "39,600 BHD"),
                YearlyGrowthElementType("TERM", "10 years"),
                YearlyGrowthElementType("STRATEGY", "Moderate"),
                YearlyGrowthElementType("CONTRIBUTION", "249 BHD"),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                YearlyAverageGrowthElementType(
                  "Year",
                  "Contribution",
                  "Average growth (7%)",
                  "Surrender value",
                  isTitle: true,
                ),
                YearlyAverageGrowthElementType(
                    "1", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "2", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "3", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "4", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "5", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "6", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "7", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "8", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "9", "3686", "3,686.1", "3,686.1"),
                YearlyAverageGrowthElementType(
                    "10", "3686", "3,686.1", "3,686.1"),
              ],
            ),
          ),
          CustomSpacer(
            value: Dimensions.PADDING_SIZE_DEFAULT,
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
              CustomButton(
                title: 'confirm'.tr,
                width: 114,
                fontSize: 12,
                height: 26,
                buttonAction: () {},
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
