import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomInternationalPhoneValidate extends StatelessWidget {
  final PhoneNumber initialPhoneNumber;
  final TextEditingController phoneController;
  final Function onSaved;
  final Function(String) dailCode, onChange;
  final String hintText;

  const CustomInternationalPhoneValidate(
      {Key key,
      this.initialPhoneNumber,
      this.phoneController,
      this.onChange,
      this.onSaved,
      this.dailCode = _dummyOnFocusChange,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      spaceBetweenSelectorAndTextField: 0,
      onInputChanged: (PhoneNumber number) {
        dailCode(number.dialCode);
        onChange(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        debugPrint("INTERNATIONAL_VALID $value");
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        useEmoji: true,
      ),
      ignoreBlank: true,
      autoValidateMode: AutovalidateMode.always,
      selectorTextStyle: TextStyle(color: Colors.black),
      initialValue: initialPhoneNumber,
      textFieldController: phoneController,
      formatInput: false,
      textStyle: TextStyle(
        color: MyColors.PrimaryColor,
        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        fontSize: Dimensions.FONT_SIZE_SMALL,
      ),
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: false),
      inputBorder: OutlineInputBorder(),
      onSaved: (PhoneNumber number) {
        onSaved(number);
      },
      inputDecoration: InputDecoration(
        hintText: hintText ?? 'enter_a_phone_number'.tr,
        hintStyle: TextStyle(
          color: Color.fromRGBO(209, 215, 219, 1),
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontSize: Dimensions.FONT_SIZE_SMALL,
        ),
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        border: OutlineBorderStyleBorder,
        enabledBorder: OutlineEnabledBorderStyle,
        focusedBorder: OutlineFocusedBorderStyle,
      ),
    );
  }

  static dynamic _dummyOnFocusChange(String val) {}
}
