import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/whatsapp_deep_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_loader.dart';

class CustomDialogHelper {
  //SHOW ERROR DIALOG
  static void showErrorDialog(
      {String title = 'Error', String description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.headline6,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen) Get.back();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //SHOW LOADING
  static void showLoading({bool showLongWaitingMessage, String description}) {
    Get.dialog(
      CustomLoader(
          showLongWaitingMessage: showLongWaitingMessage,
          description: description),
      barrierDismissible: false,
    );
  }

  //HIDE LOADING
  static void hideLoading() {
    if (Get.isDialogOpen) Get.back();
  }

  static void showCustomDialog(
      {String title = 'Error',
      String description = 'Something went wrong',
      Function okBtnFunction,
      Function cancelBtnFunction}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              CustomLabel(
                title: title.capitalize,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.0),
              CustomLabel(
                title: description,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                maxLines: 10,
              ),
              SizedBox(height: 35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      title: 'ok'.tr,
                      width: null,
                      fontSize: 12,
                      height: 26,
                      bgColor: MyColors.PrimaryColor,
                      buttonAction: okBtnFunction),
                  CustomButton(
                    title: 'cancel'.tr,
                    width: null,
                    fontSize: 12,
                    height: 26,
                    bgColor: MyColors.PrimaryColor,
                    buttonAction: cancelBtnFunction,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  static void CustomDialogOkay(
      {String title = 'Error',
      String description = 'Something went wrong',
      Function okBtnFunction}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              CustomLabel(
                title: title.capitalize,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.0),
              CustomLabel(
                title: description,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                maxLines: 10,
              ),
              SizedBox(height: 35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      title: "ok",
                      width: null,
                      fontSize: 12,
                      height: 26,
                      bgColor: MyColors.PrimaryColor,
                      buttonAction: okBtnFunction),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  static void showAlertDialog(
      {String title = 'Alert',
      String description = 'Something went wrong',
      Function okBtnFunction}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              CustomLabel(
                title: title.capitalize,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.0),
              CustomLabel(
                title: description,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                maxLines: 10,
              ),
              SizedBox(height: 35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      title: "ok".tr,
                      width: null,
                      fontSize: 12,
                      height: 26,
                      bgColor: MyColors.PrimaryColor,
                      buttonAction: okBtnFunction),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  static void showAlertDialogWithHyperlink(
      {String title = 'Alert', Function okBtnFunction}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              CustomLabel(
                title: title.capitalize,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.0),
              WhatsAppDeepLinkView(),
              SizedBox(height: 35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      title: "ok".tr,
                      width: null,
                      fontSize: 12,
                      height: 26,
                      bgColor: MyColors.PrimaryColor,
                      buttonAction: okBtnFunction),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
