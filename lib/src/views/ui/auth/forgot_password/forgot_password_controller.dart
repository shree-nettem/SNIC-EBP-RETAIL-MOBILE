import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController phoneController;
  TextEditingController otpController;

  var phoneNumber;
  String initialCountry = 'BH';
  PhoneNumber number;
  String selectedCountryCode = "+973";

  @override
  void onInit() {
    super.onInit();
    print("init");
    phoneController = TextEditingController();
    otpController = TextEditingController();
    // formKey = GlobalKey<FormState>();
    // confirmFormKey = GlobalKey<FormState>();
    number = PhoneNumber(isoCode: 'BH');
  }

  void setPhoneNumber(value) {
    phoneNumber = value;
  }

  void forgotPasswordPhoneOTP({bool resendOtp = false}) {
    if (Utils.isInternetConnected() != null) {
      var data = {
        "PhoneNumber": parseNumber(),
        "RequestType": "sms",
        "CountryCode": selectedCountryCode
      };
      requestPhoneOTP(data, resendOtp: resendOtp);
    } else {
      errorMessage("Please connect to the network");
      phoneController.text = '';
    }
  }

  //Parse the phone number - display phone without country code
  parseNumber() {
    return this
        .phoneController
        .text
        .replaceAll("+${this.selectedCountryCode}", '');
  }

  Future<void> requestPhoneOTP(data, {bool resendOtp = false}) async {
    Result result =
        await DioClient().post('ForgotPassword?customer=true', data);
    if (result is SuccessState) {
      bool jsonData = result.value;
      if (jsonData is bool) {
        if (resendOtp) {
          successMessage("OTP sent successfully");
        } else {
          Get.toNamed(AppRoutes.FORGOT_PASSWORD_VERIFY_OTP);
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
      phoneController.text = '';
    }
  }

  void updatedCountryCode(String val) {
    selectedCountryCode = val;
  }

  void validatingOTP(String otp, {bool resendOtp = false}) async {
    var data = {
      "PhoneNumber": parseNumber(),
      "RequestType": "sms",
      "CountryCode": selectedCountryCode,
      "code": otp
    };

    Result result =
        await DioClient().post('ValidateForgotPassword?customer=true', data);
    if (result is SuccessState) {
      bool jsonData = result.value;
      if (jsonData is bool) {
        if (jsonData) {
          verifyOTP();
        } else {
          errorMessage("enterValidOTP".tr);
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  //VERIFY OTP
  verifyOTP() {
    debugPrint("OTP " + otpController.text);
    Get.toNamed(AppRoutes.RESET_PASSWORD, arguments: [
      {"otp": otpController.text},
      {"phone": parseNumber()}
    ]);
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.dispose();
    otpController.dispose();
  }
}
