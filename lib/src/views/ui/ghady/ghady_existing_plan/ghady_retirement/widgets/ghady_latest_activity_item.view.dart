import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';

class GhadyLatestActivityItemView extends StatelessWidget {
  final String title;
  final String value;
  final String date;
  GhadyLatestActivityItemView(this.title, this.value, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(
            title: date,
            color: MyColors.GrayColor,
            fontSize: 12,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomLabel(
                title: title,
                color: MyColors.PrimaryColor,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
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
            color: MyColors.view,
          ),
        ],
      ),
    );
  }
}
