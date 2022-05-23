import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_loader.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/more/notification_preference_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPreferenceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: 'notifications'.tr),
          SliverFillRemaining(
            hasScrollBody: false,
            child: NotificationPreferencesView(),
          ),
        ],
      ),
    );
  }
}

class NotificationPreferencesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<NotificationPreferenceXController>(
      init: NotificationPreferenceXController(),
      builder: (controller) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: Column(
                  children: [
                    PushNotificationView(controller: controller),
                    SizedBox(
                      height: 12,
                    ),
                    EmailNotificationView(controller: controller),
                    SizedBox(
                      height: 12,
                    ),
                    SMSNotificationView(controller: controller),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? Positioned(
                      child: Center(
                        child: CustomLoader(),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}

class PushNotificationView extends StatelessWidget {
  final NotificationPreferenceXController controller;

  const PushNotificationView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: MyColors.GrayColor,
            blurRadius: 15.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        ),
        child: Container(
          height: 66,
          margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLabel(
                  title: 'pushNotification'.tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.4,
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    border: Border.all(color: MyColors.Border),
                  ),
                  child: Obx(
                    () => CupertinoSwitch(
                      thumbColor: controller.switchNotificationValue.value
                          ? MyColors.PrimaryColor
                          : MyColors.Border,
                      activeColor: Colors.white,
                      trackColor: Colors.white,
                      value: controller.switchNotificationValue.value,
                      onChanged: (value) {
                        controller.switchNotification();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailNotificationView extends StatelessWidget {
  final NotificationPreferenceXController controller;

  const EmailNotificationView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: MyColors.GrayColor,
            blurRadius: 15.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        ),
        child: Container(
          height: 66,
          margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLabel(
                  title: 'email'.tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.4,
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    border: Border.all(color: MyColors.Border),
                  ),
                  child: Obx(
                    () => CupertinoSwitch(
                      thumbColor: controller.switchEmailValue.value
                          ? MyColors.PrimaryColor
                          : MyColors.Border,
                      activeColor: Colors.white,
                      trackColor: Colors.white,
                      value: controller.switchEmailValue.value,
                      onChanged: (value) {
                        controller.switchEmailNotification();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SMSNotificationView extends StatelessWidget {
  final NotificationPreferenceXController controller;

  const SMSNotificationView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: MyColors.GrayColor,
            blurRadius: 15.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        ),
        child: Container(
          height: 66,
          margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLabel(
                  title: 'sms'.tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.4,
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    border: Border.all(color: MyColors.Border),
                  ),
                  child: Obx(
                    () => CupertinoSwitch(
                      thumbColor: controller.switchSMSValue.value
                          ? MyColors.PrimaryColor
                          : MyColors.Border,
                      activeColor: Colors.white,
                      trackColor: Colors.white,
                      value: controller.switchSMSValue.value,
                      onChanged: (value) {
                        controller.switchSMSNotification();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
