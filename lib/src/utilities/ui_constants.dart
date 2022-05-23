import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';

import 'colors.dart' as Style;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const ExtraLargeFontSize = 30.0;
const LargeFontSize = 22.0;
const RegularFontSize = 18.0;
const MediumFontSize = 16.0;
const SmallFontSize = 14.0;
const VerySmallFontSize = 12.0;
const String FontNameDefault = 'FuturaStd';

/* ADD VERTICAL HEIGHT */
Widget addVerticalHeight(double height) {
  return SizedBox(
    height: height,
  );
}

/* ADD HORIZONTAL WIDTH */
Widget addHorizontalWidth(double width) {
  return SizedBox(
    width: width,
  );
}

/* LOADING INDICATOR */
Widget buildLoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 45.0,
          height: 45.0,
          child: CircularProgressIndicator(),
        )
      ],
    ),
  );
}

/* LOADING ERROR MESSAGE */
Widget buildErrorWidget(String error, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$error'),
      ],
    ),
  );
}

/* COMMON APPBAR */
Widget appBar(String title) {
  return AppBar(
    backgroundColor: Style.MyColors.themeColor,
    title: label(title,
        fontWeight: FontWeight.w500,
        fontSize: RegularFontSize,
        color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}

/* COMMON LABEL - TITLE IS REQUIRED */
Widget label(
  String title, {
  TextAlign textAlign = TextAlign.left,
  double fontSize = 12,
  Color color = Style.MyColors.titleColor,
  FontWeight fontWeight = FontWeight.w600,
  int maxLines = 1,
}) {
  return Text(
    title,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'FuturaStd',
    ),
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

enum InputTypeEnum {
  alpha,
  numeric,
  alphanumeric,
  alphaDigits
}

/* COMMON TEXT FIELD */
Widget textField(
    {@required TextEditingController textController,
    TextInputType textInputType = TextInputType.text,
    String labelText,
    String hintText,
    ValueChanged<String> onChanged,
    String errorText = 'Value Can\'t Be Empty',
    FocusNode focusNode,
    IconData iconData,
    VoidCallback onTapAction,
    InputTypeEnum keyboardInputType = InputTypeEnum.alphanumeric,
    int iType = 0,
    bool validate = false,
    bool isObscureText = false,
    bool textArea = false,
    bool isEnabled = true,
    bool isReadOnly = false,
    bool isTextArea = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
    child: TextField(
      autofocus: false,
      maxLines: isTextArea ? 5 : 1,
      onChanged: onChanged,
      minLines: 1,
      keyboardType: isTextArea ? TextInputType.multiline : textInputType,
      textInputAction:
          isTextArea ? TextInputAction.newline : TextInputAction.next,
      controller: textController,
      focusNode: focusNode,
      obscureText: isObscureText,
      enabled: isEnabled,
      readOnly: isReadOnly,
      inputFormatters: [
        (keyboardInputType == InputTypeEnum.alpha)
            ? FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
            : (keyboardInputType == InputTypeEnum.numeric)
                ? FilteringTextInputFormatter.digitsOnly
                : LengthLimitingTextInputFormatter(200),
      ],
      onTap: onTapAction,
      style: TextStyle(fontFamily: FontNameDefault),
      decoration: InputDecoration(
        prefixIcon: ((iconData != null)
            ? Icon(
                iconData,
                color: Style.MyColors.themeColor,
              )
            : null),
        errorText: validate ? errorText : null,
        border: OutlineBorderStyleBorder,
        enabledBorder: OutlineEnabledBorderStyle,
        focusedBorder: OutlineFocusedBorderStyle,
        labelText: labelText,
        labelStyle: TextStyle(
            color: Style.MyColors.titleColor, fontSize: MediumFontSize),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Style.MyColors.titleColor, fontSize: MediumFontSize),
        filled: true,
      ),
    ),
  );
}

/* COMMON BUTTON */
Widget button(String title, VoidCallback buttonAction,
    {double fontSize = 16.0,
    isActive = true,
    width = 200.0,
    height = 50.0,
    isRemove = false,
    isOutlined = false,
    isRounded = true}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: isOutlined
          ? buttonOutlineStyle(
              backgroundColor: isActive
                  ? Style.MyColors.themeColor
                  : Style.MyColors.titleColor,
              borderColor: isRemove ? Colors.red : Style.MyColors.themeColor,
              radius: isRounded ? 24.0 : 0,
            )
          : buttonStyle(
              backgroundColor: isActive
                  ? Style.MyColors.themeColor
                  : Style.MyColors.titleColor,
              borderColor: isActive
                  ? Style.MyColors.themeColor
                  : Style.MyColors.themeColor,
              radius: isRounded ? 8.0 : 0,
            ),
      onPressed: buttonAction,
      child: isOutlined
          ? isRemove
              ? label(title, fontSize: fontSize, color: Colors.red)
              : label(title,
                  fontSize: fontSize, color: Style.MyColors.themeColor)
          : label(title,
              fontSize: fontSize, color: Style.MyColors.buttonTitleColor),
    ),
  );
}

ButtonStyle buttonStyle(
    {Color backgroundColor = Colors.black, double radius, Color borderColor}) {
  return ButtonStyle(
    alignment: Alignment.center,
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        side: (borderColor != null)
            ? BorderSide(color: borderColor)
            : BorderSide(),
      ),
    ),
  );
}

ButtonStyle buttonOutlineStyle(
    {Color backgroundColor = Colors.white, double radius, Color borderColor}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 2.0),
      ),
    ),
  );
}

/* BASIC STYLE */
textStyle(double fontSize, var textWeight, var color) {
  return TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: textWeight,
    fontSize: fontSize,
    color: color,
  );
}

textStyleWithoutColor(double fontSize, var textWeight) {
  return TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: textWeight,
    fontSize: fontSize,
  );
}

const disableBorderStyleBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.white,
  ),
);

/* OUTLINE BORDER STYLE DECORATION */
const OutlineBorderStyleBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: const Color.fromRGBO(209, 215, 219, 1),
  ),
  borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ),
);

/* OUTLINE ENABLED BORDER STYLE DECORATION */
const OutlineEnabledBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: const Color.fromRGBO(209, 215, 219, 1),
  ),
  borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ),
);

/* OUTLINE FOCUSED BORDER STYLE DECORATION */
const OutlineFocusedBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: const Color.fromRGBO(209, 215, 219, 1),
  ),
  borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ),
);

/* PLANE OULINE BORDER STYLE DECORATION */
const PlaneOutlineBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
  borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ),
);

/*  ROUNDED OUTLINE BORDER STYLE DECORATION */
const RoundedOutlineBorderStyleBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: const Color.fromRGBO(209, 215, 219, 1),
  ),
  borderRadius: const BorderRadius.all(
    const Radius.circular(30.0),
  ),
);

/* ROUNDED PLANE OULINE BORDER STYLE DECORATION */
const RoundedPlaneOutlineBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
  borderRadius: const BorderRadius.all(
    const Radius.circular(30.0),
  ),
);

/* ERROR MESSAGE */
errorMessage(var message, {String title = "alert"}) {
  CustomDialogHelper.showAlertDialog(
      title: title.tr,
      description: message,
      okBtnFunction: () {
        Get.back();
      });
}

errorMessageWithAction(var message,
    {String title = "alert", Function okBtnClicked}) {
  CustomDialogHelper.showAlertDialog(
      title: title.tr, description: message, okBtnFunction: okBtnClicked);
}

//SUCCESS MESSAGE
successMessage(var message) {
  Get.showSnackbar(
    GetBar(
      message: message,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyColors.PrimaryColor,
      duration: const Duration(seconds: 3),
    ),
  );
}

//PADDING MAIN LABEL
paddingLabel(var text) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
    child: label(
      text,
      textAlign: TextAlign.left,
      fontSize: MediumFontSize,
    ),
  );
}

//COLOR Code
Color parseColor(String color) {
  String hex = color.replaceAll("#", "");
  if (hex.isEmpty) hex = "ffffff";
  if (hex.length == 3) {
    hex =
        '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
  }
  Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  return col;
}
