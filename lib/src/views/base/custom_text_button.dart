import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  final int maxLines;
  final double height,iconSize;
  final bool underLine;
  final IconData leadingIcon;
  final IconData trailingIcon;
  const CustomTextButton({
    @required this.title,
    this.leadingIcon = null,
    this.trailingIcon = null,
    this.iconSize,
    this.fontWeight = FontWeight.normal,
    this.fontSize = Dimensions.FONT_SIZE_DEFAULT,
    this.color = MyColors.PrimaryColor,
    this.fontFamily = Constants.FONT_PROXIMA_NOVA,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.height = 1.2,
    this.underLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
            visible: leadingIcon != null ? true : false,
            child: Icon(
              leadingIcon,
              color: color,
            )),
        Text(
          title,
          style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              height: height,
              decoration:
                  !underLine ? TextDecoration.none : TextDecoration.underline),
          textAlign: textAlign,
          maxLines: maxLines,
        ),
        Visibility(
            visible: trailingIcon != null ? true : false,
            child: Icon(
              trailingIcon,
              color: color,
              size: iconSize,
            )),
      ],
    );
  }
}
