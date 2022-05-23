import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLabel extends StatelessWidget {
  final String title;
  final String subTitle;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  final int maxLines;
  final double height;
  final bool underLine, multiLine;

  const CustomLabel({
    @required this.title,
    this.fontWeight = FontWeight.normal,
    this.fontSize = Dimensions.FONT_SIZE_DEFAULT,
    this.color = MyColors.PrimaryColor,
    this.fontFamily = Constants.FONT_PROXIMA_NOVA,
    this.textAlign = TextAlign.start,
    this.maxLines = 2,
    this.height = 1.2,
    this.subTitle = '',
    this.underLine = false,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title != null
                ? title.contains('*')
                    ? title.replaceAll("*", "")
                    : title
                : "",
            style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily,
                height: height,
                decoration: !underLine
                    ? TextDecoration.none
                    : TextDecoration.underline),
          ),
          TextSpan(
            text: title != null
                ? title.contains('*')
                    ? "*"
                    : ""
                : "",
            style: TextStyle(
                color: Colors.red,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily,
                height: height,
                decoration: !underLine
                    ? TextDecoration.none
                    : TextDecoration.underline),
          ),
        ],
      ),
      textAlign: textAlign,
      maxLines: multiLine ? null : maxLines,
    );
  }
}
