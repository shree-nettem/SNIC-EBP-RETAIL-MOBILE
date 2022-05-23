import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_loader.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'info_controller.dart';
import 'package:html2md/html2md.dart' as html2md;

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: CustomLoader(),
      child: Scaffold(
        backgroundColor: MyColors.MainColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSilverBar(title: 'terms_condition'.tr),
            SliverFillRemaining(
              hasScrollBody: false,
              child: TermsView(),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsView extends StatelessWidget {
  final InfoController controller = Get.put(InfoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return VisibilityDetector(
          key: Key('terms-widget-key'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0.1 && !controller.isInfoReceived) {
              debugPrint("${info.visibleFraction} of my widget is visible");
              controller.fetchInfo("Terms");
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
      },
    );
  }
}
