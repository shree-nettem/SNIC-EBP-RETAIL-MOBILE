import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utilities/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.title,
    @required this.buttonAction,
    this.width,
    this.isActive = true,
    this.height = 36.0,
    this.fontSize = Dimensions.FONT_SIZE_DEFAULT,
    this.bgColor = MyColors.PrimaryColor,
    this.paddingWidth = 20.0,
    this.isRemove = false,
    this.svgImage,
    this.languageCode = false,
  });

  final String title;
  final Function buttonAction;
  final double fontSize;
  final bool isActive;
  final double width;
  final double height;
  final bool isRemove;
  final bool isOutlined = false;
  final bool isRounded = true;
  final Color bgColor;
  final double paddingWidth;
  final String svgImage;
  final bool languageCode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: bgColor, //button's fill color
          onPrimary: Colors
              .white, //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
          onSurface: MyColors
              .GrayColor, //specify the button's disabled text, icon, and fill color
          elevation: 0, //buttons Material shadow
          textStyle: TextStyle(
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              color: Colors.white), //specify the button's text TextStyle
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  paddingWidth)), // set the buttons shape. Make its birders rounded etc
          //set the buttons shape. Make its birders rounded etc
          animationDuration:
              Duration(milliseconds: 100), //the buttons animations duration
        ),
        onPressed: buttonAction,
        child: isOutlined
            ? isRemove
                ? Directionality(
                    textDirection:
                        languageCode ? TextDirection.rtl : TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (svgImage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SvgPicture.asset(
                              svgImage,
                              height: 10,
                              width: 10,
                            ),
                          ),
                        CustomLabel(
                            title: title,
                            fontSize: fontSize,
                            color: Colors.red,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
                : Directionality(
                    textDirection:
                        languageCode ? TextDirection.rtl : TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (svgImage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SvgPicture.asset(
                              svgImage,
                              height: 10,
                              width: 10,
                            ),
                          ),
                        CustomLabel(
                            title: title,
                            fontSize: fontSize,
                            color: MyColors.themeColor,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
            : Directionality(
                textDirection:
                    languageCode ? TextDirection.rtl : TextDirection.ltr,
                child: GetBuilder<LocalizationController>(
                    builder: (localizationController) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: localizationController.locale.languageCode == 'en'
                        ? [
                            if (svgImage != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: SvgPicture.asset(
                                  svgImage,
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            CustomLabel(
                                title: title,
                                fontSize: fontSize,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                color: MyColors.buttonTitleColor,
                                fontWeight: FontWeight.bold),
                          ].reversed.toList()
                        : [
                            if (svgImage != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: SvgPicture.asset(
                                  svgImage,
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            CustomLabel(
                                title: title,
                                fontSize: fontSize,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                color: MyColors.buttonTitleColor,
                                fontWeight: FontWeight.bold),
                          ],
                  );
                }),
              ),
      ),
    );
  }
}
