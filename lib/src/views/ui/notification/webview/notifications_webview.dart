import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/notification/webview/notifications_webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationsWebview extends StatelessWidget {
  NotificationsWebview({
    Key key,
  }) : super(key: key);
  final NotificationsWebviewController controller =
      Get.put(NotificationsWebviewController());
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
                child: controller.webUrl != null
                    ? WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: controller.webUrl,
                      )
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
