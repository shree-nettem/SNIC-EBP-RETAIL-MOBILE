import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_app_bar.dart';
import 'package:ebpv2/src/views/base/custom_check_box.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_toogle.dart';
import 'package:ebpv2/src/views/ui/more/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MoreScreen extends StatelessWidget {
  final MoreXController controller = Get.put(MoreXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "",
        isBackButtonExist: false,
        isActionButtonExist: false,
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_LARGE,
                  top: Dimensions.PADDING_SIZE_LARGE,
                  bottom: Dimensions.PADDING_SIZE_LARGE),
              child: MoreScreenView(),
            ),
          );
        },
      ),
    );
  }
}

class MoreScreenView extends StatelessWidget {
  MoreScreenView();
  final MoreXController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacer(
              isHeight: true,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.CUSTOMER_PROFILE);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 30,
                          child: SvgPicture.asset(Images.account),
                        ),
                        Positioned(
                          right: 0,
                          top: 2,
                          child: SvgPicture.asset(Images.red_dot),
                        ),
                      ],
                    ),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'account'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.REFER_A_FRIEND);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SvgPicture.asset(Images.refer_a_friend),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'refer_a_friend'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      right: Dimensions.PADDING_SIZE_DEFAULT),
                  child: SvgPicture.asset(Images.settings),
                ),
                CustomSpacer(
                    isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomLabel(
                  title: 'settings'.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ],
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),

            /* Settings */
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.08,
                  margin: const EdgeInsets.only(
                      right: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      left: Dimensions.PADDING_SIZE_SMALL),
                  child: SvgPicture.asset(
                    Images.line,
                  ),
                ),
                CustomSpacer(
                    isHeight: false,
                    value: Dimensions.PADDING_SIZE_DEFAULT / 2),
                Container(
                  height: Get.height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.NOTIFICATION_PREFERENCES);
                        },
                        child: CustomLabel(
                          title: 'notification_preferences'.tr,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.CHANGE_PASSWORD);
                        },
                        child: CustomLabel(
                          title: 'change_password'.tr,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.saveBiometricLoginDetails();
                        },
                        child: Row(
                          children: [
                            CustomLabel(
                              title: 'useBiometric'.tr,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            // Spacer(),
                            Obx(() {
                              return CustomCheckBox(
                                text: "",
                                value: controller.toggleForAccount.value,
                                onTap: () {
                                  controller.toggleForAccount.toggle();
                                },
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /* TERMS AND CONDITIONS */
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.TERMS);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SvgPicture.asset(Images.terms),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'terms_and_conditions'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),

            /*LANGUAGE */
            GetBuilder<LocalizationController>(
                builder: (localizationController) {
              return GestureDetector(
                onTap: () {
                  if (localizationController.locale.languageCode == 'en') {
                    localizationController.setLanguage(Locale(
                      Constants.languages[1].languageCode,
                      Constants.languages[1].countryCode,
                    ));
                    localizationController.setSelectIndex(1);
                    if (localizationController.languages.isNotEmpty &&
                        localizationController.selectedIndex != -1) {
                      localizationController.setLanguage(Locale(
                        Constants
                            .languages[localizationController.selectedIndex]
                            .languageCode,
                        Constants
                            .languages[localizationController.selectedIndex]
                            .countryCode,
                      ));
                    }
                  } else {
                    localizationController.setLanguage(Locale(
                      Constants.languages[0].languageCode,
                      Constants.languages[0].countryCode,
                    ));
                    localizationController.setSelectIndex(0);
                    if (localizationController.languages.isNotEmpty &&
                        localizationController.selectedIndex != -1) {
                      localizationController.setLanguage(Locale(
                        Constants
                            .languages[localizationController.selectedIndex]
                            .languageCode,
                        Constants
                            .languages[localizationController.selectedIndex]
                            .countryCode,
                      ));
                    }
                  }
                },
                child: Row(
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
                      return CustomLabel(
                        title:
                            localizationController.locale.languageCode == 'en'
                                ? "العربية"
                                : "English",
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      );
                    }),
                  ],
                ),
              );
            }),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),

            /*PRIVACY POLICY */
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.PRIVACY_POLICY);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SvgPicture.asset(Images.privacy),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'privacy_policy'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),

            /* FAQS */
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.FAQS);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SvgPicture.asset(Images.help),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'faqs'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),

            /* ABOUT SNIC */
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.ABOUT_SNIC);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SvgPicture.asset(Images.about),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'about_snic'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            CustomSpacer(
                isHeight: true,
                value: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
            GestureDetector(
              onTap: () {
                debugPrint("LOG OUT ");
                AppHelper.logout();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: SvgPicture.asset(Images.log_out),
                  ),
                  CustomSpacer(
                      isHeight: false, value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: 'sign_out'.tr,
                    fontWeight: FontWeight.w600,
                    color: MyColors.RedColor,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
