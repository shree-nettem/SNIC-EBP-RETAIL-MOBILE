import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/auth/login/widgets/login_form_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginXController controller = Get.put(LoginXController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(207, 215, 219, 1),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('confirm_exit'.tr),
                  content: Text('are_you_sure_exit'.tr),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        primary: Colors.white,
                      ),
                      child: CustomLabel(
                        title: 'yes'.tr,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        primary: Colors.white,
                      ),
                      child: CustomLabel(
                        title: 'no'.tr,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        child: Scaffold(
          backgroundColor: MyColors.MainColor,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return loginUI();
              },
            ),
          ),
        ),
      ),
    );
  }

  /* LOGIN UI */
  Widget loginUI() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(207, 215, 219, 1),
            Color.fromRGBO(255, 255, 255, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 48.0, right: 48, top: 48),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*LANGUAGE */
                  GetBuilder<LocalizationController>(
                      builder: (localizationController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: false,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: Dimensions.PADDING_SIZE_DEFAULT),
                            child: SvgPicture.asset(Images.privacy),
                          ),
                        ),
                        CustomSpacer(
                            isHeight: false,
                            value: Dimensions.PADDING_SIZE_DEFAULT),
                        GetBuilder<LocalizationController>(
                            builder: (localizationController) {
                          return CustomButton(
                            title: localizationController.locale.languageCode ==
                                    'en'
                                ? "العربية"
                                : "English",
                            width: 75,
                            fontSize: 12,
                            height: 26,
                            buttonAction: () {
                              {
                                if (localizationController
                                        .locale.languageCode ==
                                    'en') {
                                  localizationController.setLanguage(Locale(
                                    Constants.languages[1].languageCode,
                                    Constants.languages[1].countryCode,
                                  ));
                                  localizationController.setSelectIndex(1);
                                  if (localizationController
                                          .languages.isNotEmpty &&
                                      localizationController.selectedIndex !=
                                          -1) {
                                    localizationController.setLanguage(Locale(
                                      Constants
                                          .languages[localizationController
                                              .selectedIndex]
                                          .languageCode,
                                      Constants
                                          .languages[localizationController
                                              .selectedIndex]
                                          .countryCode,
                                    ));
                                  }
                                } else {
                                  localizationController.setLanguage(Locale(
                                    Constants.languages[0].languageCode,
                                    Constants.languages[0].countryCode,
                                  ));
                                  localizationController.setSelectIndex(0);
                                  if (localizationController
                                          .languages.isNotEmpty &&
                                      localizationController.selectedIndex !=
                                          -1) {
                                    localizationController.setLanguage(Locale(
                                      Constants
                                          .languages[localizationController
                                              .selectedIndex]
                                          .languageCode,
                                      Constants
                                          .languages[localizationController
                                              .selectedIndex]
                                          .countryCode,
                                    ));
                                  }
                                }
                              }
                            },
                          );
                          // CustomLabel(
                          //   title:
                          //       localizationController.locale.languageCode ==
                          //               'en'
                          //           ? "العربية"
                          //           : "English",
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: Dimensions.FONT_SIZE_LARGE,
                          // );
                        }),
                      ],
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              _loginTextUI(),
              SizedBox(
                height: 32,
              ),
              _loginSubTextView(),
              SizedBox(
                height: 36,
              ),
              LoginFormView(controller: controller),
              SizedBox(
                height: 58,
              ),
              InkWell(
                onTap: () {
                  controller.usingBiometricLogin();
                },
                child: SizedBox(
                  height: 57,
                  width: 57,
                  child: SvgPicture.asset(
                    Images.scan,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _signUpUI(),
              SizedBox(
                height: 36,
              ),
              CustomLabel(
                title: 'year_snic_insurance'.tr,
                fontSize: 10,
                color: Color.fromRGBO(209, 215, 219, 1),
              ),
              SizedBox(
                height: 18,
              ),
              CustomLabel(
                title: 'licensed_by_cbb'.tr,
                fontSize: 10,
                color: Color.fromRGBO(209, 215, 219, 1),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* SNIC LOGO */
  Widget _logo() {
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset(
        Images.logo,
        width: 30,
        height: 30,
        fit: BoxFit.contain,
      ),
    );
  }

  /* LOGIN TEXT */
  Widget _loginTextUI() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: CustomLabel(
            title: 'welcome'.tr,
            textAlign: TextAlign.start,
            fontSize: 35.0,
            fontWeight: FontWeight.w600,
            fontFamily: Constants.FONT_SF_UI_DISPLAY,
          ),
        ),
      ],
    );
  }

  /* LOGIN TEXT */
  Widget _loginSubTextView() {
    return new Container(
      child: CustomLabel(
        title: 'enter_your_snic'.tr,
        textAlign: TextAlign.start,
        fontWeight: FontWeight.w600,
        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        maxLines: 3,
        height: 1.4,
      ),
    );
  }

/* DO NOT HAVE AN ACCOUNT */
  Widget _signUpUI() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'dont_have_account'.tr,
            style: TextStyle(
                color: MyColors.PrimaryColor,
                fontSize: 14,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                height: 1.4,
                decoration: TextDecoration.none),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(AppRoutes.CONFIRM_MOBILE_NUMBER);
                // controller.JUMIOCPRVerify();
              },
            text: 'register'.tr,
            style: TextStyle(
                color: Color.fromRGBO(64, 162, 190, 1),
                fontSize: 14,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                height: 1.4,
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
