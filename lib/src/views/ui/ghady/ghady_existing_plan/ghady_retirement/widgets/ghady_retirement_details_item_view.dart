import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';

class GhadyRetirementDetailsItemView extends StatelessWidget {
  final String title;
  final String value;
  GhadyRetirementDetailsItemView(this.title, this.value);

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
