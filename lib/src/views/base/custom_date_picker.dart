import 'package:ebpv2/src/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomDatePicker {
  Future<DateTime> pickDate(
      {BuildContext context,
      DateTime initialDate,
      DateTime firstDate,
      DateTime lastDate}) async {
    final DateTime picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: MyColors.PrimaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: MyColors.PrimaryColor, // button text color
                ),
              ),
            ),
            child: child,
          );
        },
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    return picked;
  }
}
