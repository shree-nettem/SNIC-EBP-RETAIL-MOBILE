import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackNextutton extends StatelessWidget {
  final bool isBackButton;
  CustomBackNextutton({Key key, this.isBackButton = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return CustomTextButton(
        leadingIcon: isBackButton
            ? localizationController.locale.languageCode == 'en'
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right
            : null,
        trailingIcon: !isBackButton
            ? localizationController.locale.languageCode == 'en'
                ? Icons.keyboard_arrow_right
                : Icons.keyboard_arrow_left
            : null,
        title: isBackButton ? "back".tr : "next".tr,
        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        maxLines: 2,
        color: MyColors.mainBackgroundColor,
      );
    });
  }
}
