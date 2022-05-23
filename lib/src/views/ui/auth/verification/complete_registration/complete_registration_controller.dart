import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CompleteRegistrationController extends GetxController {
  var registerBody;
  TextEditingController idNumberController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool savingWithGhady = false;
  bool generalInsurance = false;
  bool viewingMedicalBenefits = false;
  bool existingCustomer = false;
  String sourceOfIncome, monthlyIncome;
  String idNumber;
  int userId;

  @override
  void onInit() {
    super.onInit();
    idNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    if (Get.arguments != null) {
      registerBody = Get.arguments[0]["register_body"];
      userId = Get.arguments[0]["user_id"];
      existingCustomer = Get.arguments[0]["existing_customer"];
      savingWithGhady = registerBody["SavingWithGhady"] ?? " ";
      generalInsurance = registerBody["GeneralInsurance"] ?? " ";
      viewingMedicalBenefits = registerBody["ViewingMedicalBenefits"] ?? " ";
      sourceOfIncome = registerBody["SourceOfIncome"] ?? " ";
      monthlyIncome = registerBody["MonthlyIncome"] ?? " ";

      idNumber = registerBody["IdNumber"] ?? " ";
      idNumberController.text = idNumber;
      update();
      debugPrint("REGISTER_BODY $registerBody");
    }
  }

  void setPassword(String password) {
    password = password;
  }

  void registerNewUser() {
    var registerBody = {
      "Password": passwordController.text,
      "SavingWithGhady": savingWithGhady,
      "GeneralInsurance": generalInsurance,
      "ViewingMedicalBenefits": viewingMedicalBenefits,
      "MailingAddressTown": "",
      "MailingAddressBlock": "",
      "MailingAddressRoad": "",
      "MailingAddressHouse": "",
      "HomeAddressTown": "",
      "HomeAddressBlock": "",
      "HomeAddressRoad": "",
      "HomeAddressHouse": "",
      "SourceOfIncome": sourceOfIncome,
    };

    debugPrint("REGISTER_NEW_USER $registerBody");

    setUserProfile(registerBody);
  }

  /* POST THE DATA TO SERVER TO SET THE PROFILE */
  setUserProfile(registerBody) async {
    Result result = await DioClient()
        .post('Onboarding/SetProfileAndUser?id=$userId', registerBody);
    if (result is SuccessState) {
      Get.offAllNamed(AppRoutes.CONGRATS_ACCOUNT);
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  /* POST THE DATA TO SERVER TO SET THE PROFILE (EXISTING USER) */
  void setExistedProfileAndUser() async {
    var setExistProfileRequest = {
      "SavingWithGhady": savingWithGhady,
      "GeneralInsurance": generalInsurance,
      "ViewingMedicalBenefits": viewingMedicalBenefits,
      "MailingAddressTown": "",
      "MailingAddressBlock": "",
      "MailingAddressRoad": "",
      "MailingAddressHouse": "",
      "MailingAddressFlat": "",
      "MailingAddressAlpha": "",
      "HomeAddressTown": "",
      "HomeAddressBlock": "",
      "HomeAddressRoad": "",
      "HomeAddressHouse": "",
      "HomeAddressFlat": "",
      "HomeAddressAlpha": "",
      "SourceOfIncome": sourceOfIncome,
      "MonthlyIncome": monthlyIncome
    };

    Result result = await DioClient().post(
        'Onboarding/SetExistedProfileAndUser?id=$userId',
        setExistProfileRequest,
        isPostData: true);
    if (result is SuccessState) {
      Get.offAllNamed(AppRoutes.LOGIN);
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    idNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
