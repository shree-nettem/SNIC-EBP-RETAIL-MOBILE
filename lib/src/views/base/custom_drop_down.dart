import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomDropDown extends StatelessWidget {
  final String label;
  final List<String> options;
  final isDisableColored;
  final bool disableBorderColor;

  final String Function(String val) validator;
  final ValueChanged<String> onChanged;

  const CustomDropDown(
      {Key key,
      this.label,
      this.options,
      this.validator,
      this.onChanged,
      this.isDisableColored = false,
      this.disableBorderColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisableColored,
      child: Container(
        child: DropdownButtonFormField(
          isDense: true,
          itemHeight: 60,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          iconSize: disableBorderColor ? 0 : 20,
          icon: disableBorderColor
              ? null
              : Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 20,
                ),
          hint: CustomLabel(
            title: "select".tr,
            fontSize: 14,
            textAlign: TextAlign.start,
          ),
          validator: validator,
          style: TextStyle(
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: 12,
              color: MyColors.PrimaryColor),
          iconEnabledColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                isDisableColored ? MyColors.disableGreyColor : Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            border: disableBorderColor
                ? disableBorderStyleBorder
                : OutlineBorderStyleBorder,
            enabledBorder: disableBorderColor
                ? disableBorderStyleBorder
                : OutlineEnabledBorderStyle,
            focusedBorder: disableBorderColor
                ? disableBorderStyleBorder
                : OutlineFocusedBorderStyle,
          ),
          value: label,
          onChanged: (value) {
            onChanged(value);
          },
          selectedItemBuilder: (BuildContext context) {
            return options.map((String value) {
              return Container(
                // width: 25,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: GetBuilder<LocalizationController>(
                    builder: (localizationController) => Container(
                          height: 65,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          padding:
                              localizationController.locale.languageCode == 'en'
                                  ? EdgeInsets.fromLTRB(0, 5, 0, 5)
                                  : EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 11,
                                    color: MyColors.PrimaryColor),
                              ),
                            ],
                          ),
                        )),
              );
            }).toList();
          },
          isExpanded: true,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                height: 30,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 12,
                      color: MyColors.PrimaryColor),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
