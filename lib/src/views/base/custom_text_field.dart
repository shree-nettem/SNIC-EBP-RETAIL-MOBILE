import 'package:country_code_picker/country_code_picker.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/colors.dart' as Style;
import '../../utilities/ui_constants.dart';

class CustomTextField extends StatelessWidget {
  @required
  final TextEditingController textController;
  final TextInputType textInputType;
  final String labelText;
  final String hintText;
  final String errorText;
  final String image;
  final FocusNode focusNode = null;
  final IconData iconData = null;
  final Function onTapAction;
  final InputTypeEnum keyboardInputType = InputTypeEnum.alphanumeric;
  final int iType = 0;
  final bool validate;
  final bool isObscureText;
  final bool textArea;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isTextArea;
  final bool isSuffix;
  final bool isDisableColored;
  final bool showcountryCodePicker;
  final String Function(String val) validator;
  final ValueChanged<String> onChanged;
  final ValueChanged<CountryCode> countryCodeOnChanged;
  final Function onSaved;
  final mobileCountryCode;
  final bool showcurrencyPicker;
  final String initialCurrency;
  final List<String> totalCurrencies;
  final ValueChanged<String> currencyOnChanged;
  final Function onSuffixIconTap;
  final bool requiredLargeTextArea;
  final bool isPercentageField;
  final bool isOtpField;
  final bool restrictSpecialCharecter;
  final bool isDecimalAmount;

  const CustomTextField(
      {this.textController,
      @required this.labelText,
      @required this.hintText,
      this.textInputType = TextInputType.text,
      this.onChanged,
      FocusNode focusNode,
      IconData iconData,
      this.onTapAction,
      this.isSuffix = false,
      this.showcountryCodePicker = false,
      this.image,
      InputTypeEnum keyboardInputType = InputTypeEnum.alphanumeric,
      int iType = 0,
      this.validate = false,
      this.isObscureText = false,
      this.textArea,
      this.isEnabled,
      this.isReadOnly = false,
      this.isTextArea = false,
      this.requiredLargeTextArea = false,
      this.validator,
      this.isDisableColored = false,
      this.errorText,
      this.onSaved,
      this.countryCodeOnChanged,
      this.showcurrencyPicker = false,
      this.mobileCountryCode = "+973",
      this.currencyOnChanged,
      this.totalCurrencies,
      this.initialCurrency = "BHD",
      this.onSuffixIconTap,
      this.isPercentageField = false,
      this.isOtpField = false,
      this.isDecimalAmount = false,
      this.restrictSpecialCharecter = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autofocus: false,
        maxLines: isTextArea ? 5 : 1,
        onChanged: onChanged,
        minLines: requiredLargeTextArea ? 5 : 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: isTextArea
            ? TextInputType.multiline
            : isDecimalAmount
                ? TextInputType.numberWithOptions(decimal: true)
                : textInputType,
        textInputAction:
            isTextArea ? TextInputAction.newline : TextInputAction.next,
        controller: textController,
        focusNode: focusNode,
        obscureText: isObscureText,
        enabled: isEnabled,
        readOnly: isReadOnly,
        inputFormatters: [
          (keyboardInputType == InputTypeEnum.alpha)
              ? FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
              : (keyboardInputType == InputTypeEnum.numeric)
                  ? FilteringTextInputFormatter.digitsOnly
                  : (keyboardInputType == InputTypeEnum.alphaDigits)
                      ? FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                      : LengthLimitingTextInputFormatter(200),
          if (isPercentageField)
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
          else if (isOtpField)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          if (restrictSpecialCharecter)
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
          else if (isDecimalAmount)
            FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))
        ],
        onTap: () {
          onTapAction;
        },
        style: TextStyle(
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontSize: 12,
            color: MyColors.PrimaryColor),
        decoration: InputDecoration(
          errorMaxLines: 2,
          prefixIcon: ((iconData != null)
              ? Icon(
                  iconData,
                  color: Style.MyColors.themeColor,
                )
              : showcountryCodePicker
                  ? SizedBox(
                      height: 50,
                      child: CountryCodePicker(
                        flagWidth: 20,
                        backgroundColor: MyColors.GrayColor,
                        onChanged: countryCodeOnChanged,
                        initialSelection: mobileCountryCode,
                        showCountryOnly: false,
                        showFlag: true,
                        showDropDownButton: true,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                    )
                  : showcurrencyPicker
                      ? SizedBox(
                          height: 40,
                          width: 75,
                          child: Container(
                            decoration: BoxDecoration(
                              // color: MyColors.disableGreyColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SizedBox(
                                    width: 43,
                                    height: 41,
                                    child: CustomDropDown(
                                      disableBorderColor: true,
                                      label: initialCurrency,
                                      options: totalCurrencies ?? ['BHD'],
                                      onChanged: currencyOnChanged,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    size: 20,
                                    color: MyColors.PrimaryColor,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: Color.fromRGBO(209, 215, 219, 1),
                                    width: 1,
                                    height: 44,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ))
                      : null),
          suffixIcon: isSuffix
              ? IconButton(
                  onPressed: () {
                    onSuffixIconTap();
                  },
                  icon: new SvgPicture.asset(
                    image,
                    width: 16.74,
                    height: 15.45,
                  ),
                )
              : null,
          errorText: validate ? errorText : null,
          errorStyle: textController.text.isEmpty
              ? TextStyle(
                  color: Theme.of(context).errorColor, // or any other color
                )
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          border: OutlineBorderStyleBorder,
          enabledBorder: OutlineEnabledBorderStyle,
          focusedBorder: OutlineFocusedBorderStyle,
          labelText: labelText,
          labelStyle: TextStyle(
              color: Style.MyColors.PrimaryColor,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: Dimensions.FONT_SIZE_SMALL),
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
              color: Color.fromRGBO(209, 215, 219, 1),
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: Dimensions.FONT_SIZE_SMALL),
          filled: true,
          fillColor:
              isDisableColored ? MyColors.disableGreyColor : Colors.white,
        ),
        validator: validator,
        onSaved: (string) {
          onSaved.call(string);
        },
      ),
    );
  }
}
