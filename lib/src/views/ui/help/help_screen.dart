import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/help/help_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({Key key}) : super(key: key);

  final HelpScreenXController controller = Get.put(HelpScreenXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: MyColors.MainColor,
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(title: "help".tr),
              SliverFillRemaining(
                hasScrollBody: false,
                child: HelpBody(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HelpBody extends StatelessWidget {
  const HelpBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        title: "SNIC",
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      ),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomLabel(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: null,
                        title: "Dummy text",
                      ),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
