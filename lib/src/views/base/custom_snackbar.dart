import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = false}) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : MyColors.PrimaryColor,
    message: message,
    duration: Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
    borderRadius: Dimensions.RADIUS_EXTRA_LARGE,
    isDismissible: false,
    dismissDirection: DismissDirection.horizontal,
  ));
}
