import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:flutter/material.dart';

class CustomDropDownView extends StatelessWidget {
  final String label;
  final List<String> options;
  final isDisableColored;

  final String Function(String val) validator;
  final ValueChanged<String> onChanged;

  const CustomDropDownView(
      {Key key,
      @required this.label,
      @required this.options,
      this.validator,
      this.onChanged,
      this.isDisableColored = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField<String>(
        isDense: true,
        hint: Text(
          "Select",
          textAlign: TextAlign.start,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 20,
        ),
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
          border: OutlineBorderStyleBorder,
          enabledBorder: OutlineEnabledBorderStyle,
          focusedBorder: OutlineFocusedBorderStyle,
        ),
        value: label,
        onChanged: (value) {
          onChanged(value);
        },
        selectedItemBuilder: (BuildContext context) {
          return options.map((String val) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                // height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: Text(
                  val,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 12,
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
