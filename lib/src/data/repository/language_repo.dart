import 'package:ebpv2/src/models/language_model.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return Constants.languages;
  }
}
