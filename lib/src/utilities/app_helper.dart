import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AppHelper {
  static void saveKeepMeSignedIn(bool value) {
    final _sharedPreferencesHelper = SharedPreferencesHelper();
    _sharedPreferencesHelper.setKeepMeSignedIn(value);
  }

  static Future<bool> signedIn() async {
    final _sharedPreferencesHelper = SharedPreferencesHelper();
    bool isSignedIn = await _sharedPreferencesHelper.isSignedIn;
    if (isSignedIn == null || !isSignedIn) {
      return false;
    }
    return isSignedIn;
  }

  static Future<String> landingScreenDetails() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    bool isSignedIn = await _sharedPreferencesHelper.isSignedIn;
    if (isSignedIn == null || !isSignedIn) {
      return AppRoutes.LOGIN;
    } else {
      bool isNewUser = await _sharedPreferencesHelper.isNewUser;
      print("IS NEW USER $isNewUser");
      if (isNewUser == null || !isNewUser) {
        return AppRoutes.DASHBOARD;
      } else {
        return AppRoutes.DASHBOARD;
      }
    }
  }

  static void saveCheckUser(bool value) {
    final _sharedPreferencesHelper = SharedPreferencesHelper();
    _sharedPreferencesHelper.setNewUser(value);
  }

  //CHECK IF THE USER IS NEW OR NOT
  static Future<bool> checkForNewUser() async {
    final _sharedPreferencesHelper = SharedPreferencesHelper();
    bool isUserNew = await _sharedPreferencesHelper.isNewUser;
    if (isUserNew == null || !isUserNew) {
      return false;
    }
    return isUserNew;
  }

  //LOGOUT
  static void logout() {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    _sharedPreferencesHelper.removeUserDetails();

    Get.offAndToNamed(AppRoutes.LOGIN);
  }

  //CONVERT DATE
  static convertUTC2Local(DateTime createdOn,
      {outputFormat = "dd MMM yyyy hh:mm a"}) {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
        .parse(createdOn.toIso8601String(), true);
    var dateLocal = dateTime.toLocal();
    var localDateFormatString =
        DateFormat(outputFormat).format(dateLocal).toString();
    return localDateFormatString;
  }

  Future<String> getMobileNumber(String phnnumber,
      {bool requiredDailCode = false}) async {
    PhoneNumber number;
    try {
      number = await PhoneNumber.getRegionInfoFromPhoneNumber(phnnumber);
      debugPrint(PhoneNumber.getParsableNumber(number).toString());
    } catch (e) {
      return '';
    }

    if (requiredDailCode) {
      print(number.dialCode);
      return "+${number.dialCode}";
    }

    // try {
    return number.phoneNumber
        .replaceAll('+', '')
        .replaceFirst(number.dialCode, '');
    // } catch (e) {
    //   return '';
    // }
  }

  static parseNumber(val, initialCountry) {
    return val.replaceAll("+$initialCountry", '');
  }
}
