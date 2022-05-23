import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:flutter/material.dart';

class MedicalGroupCustomDropDown extends StatelessWidget {
  final String label;
  final List<String> options;
  final isDisableColored;
  final bool isRoundedCorner;
  final bool lang;

  final String Function(String val) validator;
  final ValueChanged<String> onChanged;

  const MedicalGroupCustomDropDown(
      {Key key,
      @required this.label,
      @required this.options,
      this.validator,
      this.onChanged,
      this.isRoundedCorner = false,
      this.isDisableColored = false,
      this.lang = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: DropdownButtonFormField<String>(
        isDense: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 20,
        ),
        validator: validator,
        style: TextStyle(
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontSize: 12,
            color: MyColors.PrimaryColor),
        iconEnabledColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.disableGreyColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 18.0),
          border: isRoundedCorner
              ? RoundedOutlineBorderStyleBorder
              : OutlineBorderStyleBorder,
          enabledBorder: isRoundedCorner
              ? RoundedPlaneOutlineBorderStyle
              : PlaneOutlineBorderStyle,
          focusedBorder: isRoundedCorner
              ? RoundedPlaneOutlineBorderStyle
              : PlaneOutlineBorderStyle,
        ),
        value: label,
        onChanged: (value) {
          onChanged(value);
        },
        selectedItemBuilder: (BuildContext context) {
          return options.map((String value) {
            return Container(
              alignment: lang == null
                  ? Alignment.centerLeft
                  : lang
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                // height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                padding: EdgeInsets.fromLTRB(0, 2.5, 10, 0),
                child: Text(
                  value,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColors.PrimaryColor),
                ),
              ),
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
                style: TextStyle(
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 12,
                    color: MyColors.PrimaryColor),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
