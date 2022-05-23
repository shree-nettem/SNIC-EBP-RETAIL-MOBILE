import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class MedicalGroupCustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const MedicalGroupCustomSearchBar({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width - 120,
      child: TextFormField(
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.disableGreyColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
          border: RoundedOutlineBorderStyleBorder,
          enabledBorder: RoundedPlaneOutlineBorderStyle,
          focusedBorder: RoundedPlaneOutlineBorderStyle,
        ),
      ),
    );
  }
}
