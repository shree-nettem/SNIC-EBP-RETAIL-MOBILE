import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/auth/login/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'login_model.dart';

class LoginXController extends GetxController {
  TextEditingController emailController, passwordController;
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  bool isValid = false;
  bool rememberMe = false;
  String email;
  String password;
  String dbemail;
  String dbpassword;

  bool isArabicLang = false;

  bool isLoading = false;

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  SharedPreferencesHelper _sharedPreferencesHelper;
  String _message = "Not Authorized";

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rememberMe = false;
    _sharedPreferencesHelper = SharedPreferencesHelper();
    super.onInit();
  }

  void setEmail(String email) {
    email = email;
  }

  void setPassword(String password) {
    password = password;
  }

  getEmail() => emailController.text.trim();

  getPassword() => passwordController.text.trim();

  //REMEMBER ME CHECKBOX IF IS CHECKED = THEN REMEMBER ME IS TRUE OR ELSE FALSE
  void isRemembered(bool isChecked) {
    rememberMe = isChecked ? true : false;
    update();
  }

  //BUTTON CLICK
  void submit() {
    _unFocus();
    if (Utils.isInternetConnected() != null) {
      loginUser();
    } else {
      errorMessage("Please connect to the network");
    }
  }

  loginUser({isBiometric = false}) async {
    update();
    var loginMap = {
      "UserName": isBiometric ? dbemail : getEmail(),
      "Password": isBiometric ? dbpassword : getPassword(),
      "AppID": "EBP_RETAIL",
    };

    debugPrint("LOGIN $loginMap");

    Result result = await DioClient().post('Authenticate', loginMap);
    if (result is SuccessState) {
      update();
      var jsonData = LoginModel.fromJson(result.value);
      if (jsonData is LoginModel) {
        int currentStepId = jsonData.onboarding.currentStepId;
        /* STEP ID 5 -> CUSTOMER VERIFIED COMPLETELY AND LOGIN */
        if (currentStepId == 5) {
          var companyId = jsonData.companies[0].companyID;
          var userId = jsonData.id;
          SharedPreferencesHelper().setUserId(userId);
          SharedPreferencesHelper()
              .setEmail(isBiometric ? dbemail : getEmail());
          SharedPreferencesHelper()
              .setPassword(isBiometric ? dbpassword : getPassword());
          SharedPreferencesHelper()
              .setCustomerId(jsonData.customerId.toString());
          SharedPreferencesHelper()
              .setReferralCode(jsonData.referralCode.toString());
          SharedPreferencesHelper()
              .setNumberOfReferrals(jsonData.numberOfReferrals);
          token(companyId, isBiometric: isBiometric);
        } else if (currentStepId == 3) {
          var userId = jsonData.onboarding.id;
          /* IDENTITY VERIFICATION HAS TO BE DONE */
          Get.toNamed(AppRoutes.IDENTITY_VERIFICATION_REQUIRED, arguments: {
            'id': userId,
            "step_id": 3,
            'email': isBiometric ? dbemail : getEmail(),
            'password': isBiometric ? dbpassword : getPassword()
          });
        } else if (currentStepId == 4) {
          var userId = jsonData.onboarding.id;
          /* ONLY THE IDENTITY HAS BEEN VERIFIED */
          Get.toNamed(AppRoutes.IDENTITY_VERIFICATION_COMPLETED, arguments: {
            'id': userId,
            "step_id": 4,
          });
        } else {
          errorMessage("Your account is not activated!");
        }
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg);
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  // registerDevice() async {
  //   var postMap = {
  //     "FcmDeviceContract": {
  //       "FcmToken":
  //           "eHjSVXTyQvChH5cKh8Oho8:APA91bHgKnOEfpn28uFM5Z0gBZBRZ-TBq5k8N8vsFjFsFI5FJm5rc50kMwmcTw-jHTX3G65IC5Gh9Zjumo0XaQczRTAaBsfaT8DgVRbn3RzYL82FVM_zMukixtehrgZOZ6O7PGxVtIAs"
  //     },
  //     "ApiToken":
  //         "3cw+APx2Au/y1KMa+HDr9FFUhvT9kf19vULYQ8iU95Ayf9hcR8twC8mFYdjC1Lp7IIJSgNkl1hUPk0G2tyw3JLpAmSvPK0oXrNYewAERifsE/xgvfCaassvcprXJoqZdkD9OCAhwgoEuyxhd4JrKP+2N2cwtFbJWjd2prEK6aRnQLaySNhoj9Kdrsi6/V6CT4KlSG/hvvxklMldPsqiFXmtYAQmDb7cv2JHxXPQuQqjxfX5FdOtg0N/3LRUICfYKiI39aD/f79jmRvqveJQtIhca+B5C1IiSrTtPC6PjnnBewh9ziK+KUzN9cr/Qzeuuy0IidIK6RKoXVFVqaD9ttw=="
  //   };

  //   var organizationId = "0f2bf5a9-e272-4d42-a489-7d7c21a11ab0";
  //   var appId = "a746487c-c59f-ec11-b400-6045bd8db111";
  //   var userId = "aa972147-f66c-e911-a994-000d3a180b20";
  //   var publicEndPoint = "https://public-eur.mkt.dynamics.com";

  //   var url =
  //       "$publicEndPoint/api/v1.0/orgs/$organizationId/pushchannel/apps/$appId/devices/$userId";

  //   Result result = await DioClient().postTest(url, postMap);

  //   if (result is SuccessState) {
  //     successMessage("Success");
  //   } else {
  //     errorMessage("Error");
  //   }
  // }

  token(int companyId, {isBiometric = false}) async {
    var requestMap = {
      "Username": isBiometric ? dbemail : getEmail(),
      "Password": isBiometric ? dbpassword : getPassword(),
      "grant_type": "password",
      "AppID": "EBP_RETAIL",
      "CompanyID": companyId,
      "InsurerID": 2,
    };

    Result result = await DioClient().post('token', requestMap);
    if (result is SuccessState) {
      var jsonData = TokenModel.fromJson(result.value);
      if (jsonData is TokenModel) {
        jsonData.companyId = companyId.toString();
        saveUserDetails(jsonData);
        Get.offAndToNamed(AppRoutes.DASHBOARD);
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  // SAVING DETAILS IN SHARED PREFERENCES
  void saveUserDetails(TokenModel tokenModel) async {
    var userDetails = TokenModel(
        accessToken: tokenModel.accessToken,
        tokenType: tokenModel.tokenType,
        expiresIn: tokenModel.expiresIn,
        name: tokenModel.name,
        companies: tokenModel.companies,
        issued: tokenModel.issued,
        expires: tokenModel.expires,
        companyId: tokenModel.companyId);

    AppHelper.saveKeepMeSignedIn(true);
    SharedPreferencesHelper.saveUserDetails(userDetails);
  }

  @override
  void onClose() {
    _unFocus();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _unFocus() {
    this.emailFocusNode.unfocus();
    this.passwordFocusNode.unfocus();
  }

  void usingBiometricLogin() {
    checkingForBioMetrics().then((value) {
      if (value) {
        authorizeUser().then((successValue) {
          if (successValue == "Authorized") {
            getUsernameAndPasswordFromDB().then((dbvalue) {
              if (dbvalue != null && dbvalue != "") {
                loginUser(isBiometric: true);
              } else {
                successMessage(
                    "allow_biometric_in_setting".tr);
              }
            });
          } else {
            successMessage("Biometric login failed");
          }
        });
      } else {
        successMessage("Biometric login is not availale");
      }
    });
  }

  void cancelAuthentication() {
    _localAuthentication.stopAuthentication();
  }

  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print(canCheckBiometrics);
    return canCheckBiometrics;
  }

  Future<String> authorizeUser() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason:
            "Required biometric authentication to login", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );

      return authenticated ? "Authorized" : "Not Authorized";
    } catch (e) {
      return "Not Authorized";
    }
  }

  Future<String> getUsernameAndPasswordFromDB() async {
    dbemail = await _sharedPreferencesHelper.getBioMetricEmail;
    dbpassword = await _sharedPreferencesHelper.getBioMetricPassword;

    return dbpassword;
  }
}
