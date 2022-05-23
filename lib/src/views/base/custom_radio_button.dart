import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'custom_label.dart';

class CustomRadioButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool value;
  final String subText;

  const CustomRadioButton(
      {@required this.text, this.onTap, this.value = false, this.subText = ""});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              height: 15.0,
              width: 15.0,
              decoration: new BoxDecoration(
                color: value ? MyColors.PrimaryColor : Colors.white,
                border:
                    new Border.all(width: 1.0, color: MyColors.PrimaryColor),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0)),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      text,
                      style: TextStyle(
                          color: MyColors.PrimaryColor,
                          fontSize: 12,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (subText != "")
                      CustomLabel(
                          title: subText,
                          color: MyColors.GrayColor,
                          fontSize: 12,
                          maxLines: 4,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          fontWeight: FontWeight.w400),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
