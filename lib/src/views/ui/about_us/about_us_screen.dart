import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/about_us/info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:html2md/html2md.dart' as html2md;

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: 'about_snic'.tr),
          SliverFillRemaining(
            hasScrollBody: false,
            child: AboutUsView(),
          ),
        ],
      ),
    );
  }
}

class AboutUsView extends StatelessWidget {
  final InfoController controller = Get.put(InfoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return VisibilityDetector(
            key: Key('about-widget-key'),
            onVisibilityChanged: (VisibilityInfo info) {
              var visiblePercentage = info.visibleFraction * 100;
              if (visiblePercentage > 10 && !controller.isInfoReceived) {
                debugPrint("${info.visibleFraction} of my widget is visible");
                controller.fetchInfo("About");
              } else {
                debugPrint("${info.visibleFraction} of my widget is invisible");
              }
            },
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: MyColors.GrayColor,
                            blurRadius: 22.0,
                            offset: Offset(
                              0.0,
                              6.0,
                            ),
                          ),
                        ],
                      ),
                      child: Visibility(
                        visible: controller.isInfoReceived,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            margin: const EdgeInsets.all(26),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabel(
                                  title: 'snic'.tr,
                                  color: MyColors.PrimaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                ),
                                CustomSpacer(
                                    value: Dimensions.PADDING_SIZE_DEFAULT),
                                CustomLabel(
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  maxLines: null,
                                  title: html2md.convert(controller.info),
                                ),
                                CustomSpacer(
                                    value: Dimensions.PADDING_SIZE_DEFAULT),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
