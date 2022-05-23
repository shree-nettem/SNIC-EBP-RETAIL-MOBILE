import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/notification/notification_controller.dart';
import 'package:ebpv2/src/views/ui/notification/notifications_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationXController controller = Get.put(NotificationXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: MyColors.MainColor,
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(title: "notifications".tr),
              SliverFillRemaining(
                hasScrollBody: true,
                child: ListView.builder(
                  itemCount: controller.totalNotifications != null
                      ? controller.totalNotifications.length + 1
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == controller.totalNotifications.length)
                      return CustomSpacer(
                        value: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      );
                    return NotificationListView(
                        controller.totalNotifications[index], controller);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NotificationListView extends StatelessWidget {
  final TotalNotifications notification;
  final NotificationXController controller;
  NotificationListView(this.notification, this.controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
            right: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(
              title: notification.sentAt != null
                  ? DateFormat('MMMM dd, yyyy').format(notification.sentAt)
                  : "",
              color: MyColors.GrayColor,
            ),
            ExpansionTileCard(
              finalPadding: EdgeInsets.only(bottom: 0),
              elevation: 0.1,
              baseColor: Colors.white,
              title: CustomLabel(
                title: notification.title,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w600,
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 8, bottom: 8),
                  child: CustomLabel(
                    title: notification.content,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    maxLines: 30,
                  ),
                ),
              ],
              onExpansionChanged: (val) {
                if (val) {
                  if (notification.readAt == null) {}
                  controller.addedReadNotification(notification.id.toString());
                }
              },
            ),
            if (notification.link != null)
              if (notification.link.isNotEmpty)
                Center(
                  child: CustomButton(
                      title: 'open'.tr,
                      width: 150.0,
                      buttonAction: () {
                        Get.toNamed(AppRoutes.CUSTOM_WEBVIEW,
                            arguments: {"webUrl": notification.link});
                      }),
                ),
            if (notification.link != null)
              if (notification.link.isNotEmpty)
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
            Divider(
              height: 1,
              color: Color.fromRGBO(209, 215, 219, 1),
            ),
            CustomSpacer(
              value: Dimensions.PADDING_SIZE_DEFAULT,
            ),
          ],
        ),
      ),
    );
  }
}
