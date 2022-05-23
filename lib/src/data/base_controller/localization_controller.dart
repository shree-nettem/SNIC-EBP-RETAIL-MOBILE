import 'package:ebpv2/src/models/language_model.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({@required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(
      Constants.languages[0].languageCode, Constants.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }

    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
    bool isArabic = locale.languageCode == 'ar' ? true : false;
    sharedPreferencesHelper.setLanguagCode(isArabic);
    saveLanguage(_locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(Constants.LANGUAGE_CODE) ??
            Constants.languages[0].languageCode,
        sharedPreferences.getString(Constants.COUNTRY_CODE) ??
            Constants.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < Constants.languages.length; index++) {
      if (Constants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(Constants.languages);
    debugPrint("LOCALIZATION " + _locale.languageCode);

    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
    bool isArabic = _locale.languageCode == 'ar' ? true : false;
    sharedPreferencesHelper.setLanguagCode(isArabic);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(Constants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(Constants.COUNTRY_CODE, locale.countryCode);
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
      _languages = Constants.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      Constants.languages.forEach((language) async {
        if (language.languageName.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(language);
        }
      });
    }
    update();
  }
}
