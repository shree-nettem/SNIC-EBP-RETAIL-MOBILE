import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';

class ReviewAndAdjustElementType extends StatelessWidget {
  final String title;
  final String value;
  ReviewAndAdjustElementType(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CustomLabel(
                title: title.toUpperCase(),
                color: MyColors.VerticalDividerColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Spacer(),
              CustomLabel(
                title: value,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
              ),
            ],
          ),
          Divider(
            color: MyColors.PrimaryColor,
          ),
        ],
      ),
    );
  }
}

class YearlyGrowthElementType extends StatelessWidget {
  final String title;
  final String value;
  YearlyGrowthElementType(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CustomLabel(
                title: title.toUpperCase(),
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              Spacer(),
              CustomLabel(
                title: value,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
              ),
            ],
          ),
          Divider(
            color: MyColors.PrimaryColor,
          ),
        ],
      ),
    );
  }
}

class YearlyAverageGrowthElementType extends StatelessWidget {
  final String year;
  final String cotribution;
  final String growth;
  final String value;
  final bool isTitle;
  YearlyAverageGrowthElementType(
      this.year, this.cotribution, this.growth, this.value,
      {this.isTitle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomLabel(
                  title: year,
                  color: MyColors.PrimaryColor,
                  fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 10,
                  maxLines: 3,
                ),
              ),
              Flexible(
                child: CustomLabel(
                  title: cotribution,
                  color: MyColors.PrimaryColor,
                  fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 10,
                  maxLines: 3,
                ),
              ),
              Flexible(
                child: CustomLabel(
                  title: growth,
                  color: MyColors.PrimaryColor,
                  fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 10,
                  maxLines: 3,
                ),
              ),
              Flexible(
                child: CustomLabel(
                  title: value,
                  color: MyColors.PrimaryColor,
                  fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 10,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Divider(
            color: MyColors.PrimaryColor,
          ),
        ],
      ),
    );
  }
}
