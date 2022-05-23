import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:ebpv2/src/views/ui/motor/model/loyality_points.dart';
import 'package:flutter/widgets.dart';
import 'package:iban/iban.dart';

class AppFormFieldValidator {
  static CreditCardValidator _ccValidator = CreditCardValidator();

  static String loyaltyPointValidator(String val, {LoyalityPoints loyalty}) {
    final text = val.trimRight();
    try {
      if (loyalty != null) {
        if (loyalty.result.eligibleAmount <= 0) {
          return 'You have no sufficient loyalty points balance.';
        } else if (text.isNotEmpty &&
            double.parse(text) > loyalty.result.eligibleAmount) {
          return 'You are eligible only to redeem up to ${loyalty.result.eligibleAmount} BHD only';
        }
      }
    } catch (e) {}

    return null;
  }

  static String generalEmptyValidator(String orgText, {String errorText}) {
    final text = orgText.trimRight();
    if (text.isEmpty) {
      return errorText ?? 'This field can not be empty';
    }
    return null;
  }

  static String generalEmptyValidatorWithNoSpecialChar(String orgText) {
    String pattern = r'^[a-zA-Z ]+$';
    RegExp regExp = new RegExp(pattern);

    if (orgText.length == 0) {
      return 'This field can not be empty';
    } else if (!regExp.hasMatch(orgText)) {
      return 'Special characters are not allowed, Please enter valid string.';
    }

    return null;
  }

  static String idNumberValidatorWithOneSpecialChar(String orgText) {
    String pattern = r'^[a-zA-Z0-9-]+$';
    RegExp regExp = new RegExp(pattern);

    if (orgText.length == 0) {
      return 'This field can not be empty';
    } else if (!regExp.hasMatch(orgText)) {
      return 'Special characters are not allowed, Please enter valid string.';
    }

    return null;
  }

  static String motorValueSumValidator(String orgText) {
    try {
      if (orgText.contains('.') || orgText.contains(' ')) {
        return 'Special characters and decimals are not allowed, Please enter valid number.';
      } else if (orgText.length == 0) {
        return 'This field can not be empty';
      } else if (orgText.length > 5) {
        return 'Maximum five digit number is allowed';
      }
    } catch (e) {
      return "This field can not be empty";
    }

    return null;
  }

  static String percetageValidator(String orgText) {
    String pattern = r'^[0-9]+(.[0-9]+)?$';
    RegExp regExp = new RegExp(pattern);

    if (orgText.length == 0) {
      return 'This field can not be empty';
    } else if (!regExp.hasMatch(orgText)) {
      return 'Invalid Percentage, Please enter valid percentage.';
    } else if (double.parse(orgText) > 100) {
      return 'Invalid Percentage, Please enter valid percentage.';
    }

    return null;
  }

  static String currencyValidator(String orgText) {
    String pattern = r'^[0-9]+(.[0-9]+)?$';
    RegExp regExp = new RegExp(pattern);

    if (orgText.length == 0) {
      return 'This field can not be empty';
    } else if (!regExp.hasMatch(orgText)) {
      return 'Invalid Amount, Please enter valid Amout.';
    }

    return null;
  }

  static String customEmptyValidatorWithMessage(
      String inputText, String errorText) {
    final text = inputText.trimRight();
    if (text == null || text.isEmpty) {
      return errorText;
    }
    return null;
  }

  static String fullNameValidator(String orgText, {String errorText}) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty || text.length < 3) {
      return errorText ?? 'Full name must be at least 3 characters long';
    }
    return null;
  }

  static String firstNameValidator(String orgText, {String errorText}) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty || text.length < 3) {
      return errorText ?? 'First name must be at least 3 characters long';
    }
    return null;
  }

  static String lastNameValidator(String orgText, {String errorText}) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty || text.length < 3) {
      return errorText ?? 'Last name must be at least 3 characters long';
    }
    return null;
  }

  static String cprValidator(String orgText) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty || text.length < 9) {
      return 'Please enter valid CPR number or Email';
    }
    return null;
  }

  static String otpValidator(String orgText) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty || text.length < 6) {
      return 'OTP code must be 6 digits long';
    }
    return null;
  }

  static String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{8,12}$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return 'Please enter a phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid Phone Number. Please enter valid phone number ';
    }

    return null;
  }

  static String validateCPR(String value) {
    return 'ID number must be all numeric and 9-15 digits long. ';
  }

  static String phoneValidator(String orgText) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty) {
      return 'Please enter a valid phone number';
    }
    bool validBHNumber =
        RegExp(r"^(:\+973)(:50|51|52|55|56|2|3|4|6|7|9)\d{7}$").hasMatch(text);

    debugPrint('Valid UAE:$validBHNumber');
    if (validBHNumber) {
      return 'Invalid Phone Number. Please enter valid phone number after the already appended prefix.';
    }
    return null;
  }

  static String emailValidator(String orgText) {
    final text = orgText.trimRight();
    var errorMessage = 'Please enter a valid email address';
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.#$%&'*+-/=^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
    if (!emailValid) {
      return errorMessage;
    }
    return null;
  }

  static String passwordValidator(String orgText) {
    final text = orgText.trimRight();
    var errorMessage = 'Please enter a valid password';
    if (text.length < 8) {
      return errorMessage;
    }
    if (_isPasswordCompliant(text)) {
      errorMessage =
          'Password must has eight characters, a digit, a special character, an upper and lowered case character';
      return errorMessage;
    }
    
    return null;
  }
  

  static bool _isPasswordCompliant(String password, [int minLength = 8]) {
    if (password.length < minLength) return false;
    if (password.contains(RegExp(r"[a-z]"))) return false;
    if (password.contains(RegExp(r"[A-Z]"))) return false;
    if (password.contains(RegExp(r"[0-9]"))) return false;
    if (password.contains(RegExp(r'[@#$%^&*(),.":{}|<>]'))) return false;
    return true;
  }

  static String generalDropDownValidator(String orgText) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty || text == 'SELECT' || text == 'Select') {
      return 'Please select any one option';
    }
    return null;
  }

  static String passwordConfirmValidator(String orgText, String oldPassword) {
    final text = orgText.trimRight();
    var errorMessage = 'Please enter a valid password';
    var misMatchedError = 'Password mismatched';
    if (generalEmptyValidator(text) != null) {
      return errorMessage;
    }
    if (text != oldPassword) {
      return misMatchedError;
    }
    return null;
  }

  static String iBanValidator(String orgText) {
    final text = orgText.trimRight();
    if (text == null || text.isEmpty) {
      return 'This field can not be empty';
    }
    if (!isValid(text)) {
      return 'Invalid IBAN Number. Please enter valid IBAN number.';
    }

    return null;
  }

  static String creditCardNumberValidator(String cardNumber) {
    final text = cardNumber.trimRight();

    var result = _ccValidator.validateCCNum(text);
    if (!result.isValid) {
      return result.message;
    } else if (text.length < 16) {
      return "invalid number";
    }
    print(result.message);
    return null;
  }

  static String creditCardsecurityCodeValidator(String val, String cardNumber) {
    CreditCardValidator _ccValidator = CreditCardValidator();

    final text = val.trimRight();
    final ccnumber = cardNumber.trimRight();

    var ccnumberesult = _ccValidator.validateCCNum(ccnumber);

    print(ccnumberesult.ccType);
    var result = _ccValidator.validateCVV(text, ccnumberesult.ccType);
    if (!result.isValid) {
      return result.message;
    }
    return null;
  }

  static String creditCardExpiryValidator(String expiry) {
    final text = expiry.trimRight();

    var result = _ccValidator.validateExpDate(text);
    if (!result.isValid) {
      return result.message;
    }
    return null;
  }

  static String vehicleNumberValidator(String value) {
    final text = value.trimRight();
    String pattern = r'^[0-9-]+$';
    RegExp regExp = new RegExp(pattern);

    if (text.isEmpty) {
      return "Vehicle Number is required";
    } else if (!regExp.hasMatch(text)) {
      return "Please enter valid vehicle number";
    } else if (text.isNotEmpty && text.length > 6) {
      return "Please enter valid vehicle number";
    }
    return null;
  }

  static String chasisNumberValidator(String value) {
    final text = value.trimRight();

    if (text.isEmpty) {
      return "Chassis Number is required";
    } else if (text.length < 6 || text.length > 20) {
      return "Please enter valid chassis number";
    }
    return null;
  }
}
