import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:flutter/material.dart';

class PDPLScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: "BAHRAIN PDPL"),
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          maxLines: 20,
                          title:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean velit magna, pretium at neque id, sagittis porttitor ante. Donec vitae leo quam."),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomLabel(
                          maxLines: 20,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          title:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean velit magna, pretium at neque id, sagittis porttitor ante. Donec vitae leo quam."),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomLabel(
                          maxLines: 20,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          title:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean velit magna, pretium at neque id, sagittis porttitor ante. Donec vitae leo quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean velit magna, pretium at neque id, sagittis porttitor ante."),
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
