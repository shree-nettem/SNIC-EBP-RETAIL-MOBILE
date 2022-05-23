import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GhadyPortfolioItemView extends StatelessWidget {
  final String title;
  final String unitPrice;
  final String totalUnits;
  final String totalAmount;

  GhadyPortfolioItemView(
      this.title, this.unitPrice, this.totalUnits, this.totalAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(
            title: title,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.FONT_SF_UI_DISPLAY,
            height: 1.7,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              CustomLabel(
                title: 'unitPrice'.tr,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 12,
              ),
              Spacer(),
              CustomLabel(
                title: 'totalUnits'.tr,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 12,
              ),
              Spacer(),
              CustomLabel(
                title: 'totalAmount'.tr,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 12,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              CustomLabel(
                title: unitPrice,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
              ),
              Spacer(),
              CustomLabel(
                title: totalUnits,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
              ),
              Spacer(),
              CustomLabel(
                title: totalAmount,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Divider(
            color: MyColors.Border,
          ),
        ],
      ),
    );
  }
}
