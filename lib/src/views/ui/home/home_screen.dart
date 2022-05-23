import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_app_bar.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/home/widget/carousel_slider_widget.dart';
import 'package:ebpv2/src/views/ui/home/widget/home_tabs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utilities/colors.dart';
import '../../../utilities/ui_constants.dart';
import 'home_controller.dart';
import 'widget/pending_payment_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeXController controller = Get.put(HomeXController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          title: "",
          isBackButtonExist: false,
        ),
        body: GetBuilder(
          init: controller,
          builder: (_) {
            return Container(
              color: MyColors.MainColor,
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: SingleChildScrollView(
                    child: HomeScreenView(controller: controller),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  final HomeXController controller;

  const HomeScreenView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomLabel(
            title: 'welcome_back'.tr,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
            color: MyColors.PrimaryColor,
          ),
          addVerticalHeight(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          CustomLabel(
            title: controller.name ?? "",
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
            color: MyColors.PrimaryColor,
            fontWeight: FontWeight.w500,
          ),
          controller.payment != null ? PendingPaymentWidget() : Container(),
          CarouselSliderWidget(controller: controller),
          HomeTabsWidget('saving_protection'.tr, Images.savings_protection,
              AppRoutes.GHADY_SAVING_HOME),
          HomeTabsWidget('motor_insurance'.tr, Images.motor_insurance,
              AppRoutes.MOTOR_INSURANCE),
          HomeTabsWidget(
              'group_life'.tr, Images.group_life, AppRoutes.GROUP_LIFE_SCREEN),
          HomeTabsWidget('group_medical'.tr, Images.medical_cross_icon,
              AppRoutes.MEDICAL_GROUP),
          HomeTabsWidget('claims'.tr, Images.claims, AppRoutes.CLAIM_SCREEN),
          HomeTabsWidget(
              'loyalty_program'.tr, Images.star, AppRoutes.LOYALTY_HOME),
          // HomeTabsWidget("More", Images.home_more, AppRoutes.LOYALTY_HOME),
          // HomeTabsWidget(
          //     "Contact form", Images.home_damaged, AppRoutes.CONTACT_FORM),
          // HomeTabsWidget(
          // "Travel Insurance", Images.home_travel, AppRoutes.LOYALTY_HOME),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        ],
      ),
    );
  }
}
