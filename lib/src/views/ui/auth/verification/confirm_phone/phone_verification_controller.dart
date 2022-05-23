import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../verification_model.dart';

class PhoneVerificationXController extends GetxController {
  TextEditingController phoneController;
  bool isChecked = false;
  bool isMyInformationChecked = false;
  bool disabled = true;
  var phoneNumber;
  GlobalKey<FormState> formKey;
  String initialCountry = 'BH';
  PhoneNumber number;
  String selectedCountryCode = "+973";

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    formKey = GlobalKey<FormState>();
    number = PhoneNumber(isoCode: 'BH');
  }

  void setPhoneNumber(value) {
    phoneNumber = value;
  }

  //ON TERMS SELECTION ON CONFIRM PHONE NUMBER SCREEN
  void onTermsChecked() {
    if (isChecked) {
      isChecked = false;
    } else {
      isChecked = true;
    }
    isEnabled();
  }

  void agreeMyInformation() {
    if (isMyInformationChecked) {
      isMyInformationChecked = false;
    } else {
      isMyInformationChecked = true;
    }
    debugPrint("IS INFORMATION $isMyInformationChecked");
    isEnabled();
  }

  isEnabled() {
    if (isChecked &&
        isMyInformationChecked &&
        AppFormFieldValidator.validateMobile(phoneController.text) == null) {
      disabled = false;
    } else {
      disabled = true;
    }
    update();
  }

  // CALL THIS API TO GET THE OTP FOR THE PHONE NUMBER
  void verifyPhone() async {
    if (Utils.isInternetConnected() != null) {
      var data = {
        "mobileNumber": parseNumber(),
        "CountryCode": selectedCountryCode
      };
      debugPrint(data.toString());
      requestPhoneOTP(data);
    } else {
      errorMessage("Please connect to the network");
    }
  }

  parseNumber() {
    return this
        .phoneController
        .text
        .replaceAll("+${this.selectedCountryCode}", '');
  }

  Future<void> requestPhoneOTP(data) async {
    Result result = await DioClient().post('Onboarding/SetMobileNumber', data);

    if (result is SuccessState) {
      var jsonData = VerificationModel.fromJson(result.value);
      if (jsonData is VerificationModel) {
        /* CURRENT STEP ID 2 -> EMAIL VERIFIED */
        if (jsonData.currentStepId == 2) {
          Get.toNamed(AppRoutes.CONFIRM_EMAIL, arguments: {
            'id': jsonData.iD,
            'phone_number': phoneController.text,
            "step_id": 2
          });
        }
        /* CURRENT STEP ID 1 -> MOBILE VERIFIED */
        else if (jsonData.currentStepId == 1) {
          Get.toNamed(AppRoutes.CONFIRM_EMAIL, arguments: {
            'id': jsonData.iD,
            'phone_number': "",
            "step_id": 1,
          });
        } else if (jsonData.currentStepId == 4) {
          Get.toNamed(
            AppRoutes.IDENTITY_VERIFICATION_COMPLETED,
            arguments: {'id': jsonData.iD, "step_id": 4},
          );
        } else {
          successMessage("An OTP has been sent to your mobile number");
          Get.toNamed(AppRoutes.VERIFY_MOBILE_NUMBER, arguments: {
            'id': jsonData.iD,
            'phone_number': phoneController.text,
            "step_id": 2
          });
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  void updatedCountryCode(String val) {
    selectedCountryCode = val;
    isEnabled();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
