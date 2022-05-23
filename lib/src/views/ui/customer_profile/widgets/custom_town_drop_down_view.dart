import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/town_model.dart';
import 'package:flutter/material.dart';

class CustomTownDropDownView extends StatelessWidget {
  final String label;
  final List<TownList> options;
  final isDisableColored;

  final String Function(String val) validator;
  final ValueChanged<String> onChanged;

  const CustomTownDropDownView(
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
          return options.map((TownList val) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                // height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: Text(
                  val.townName,
                  textAlign: TextAlign.left,
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
        items: options.map((TownList value) {
          return DropdownMenuItem<String>(
            value: value.townName,
            child: Container(
              height: 30,
              child: Text(
                value.townName,
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
