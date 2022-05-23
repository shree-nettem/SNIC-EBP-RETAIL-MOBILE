import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/auth/welcome/welcome_carousel.dart';
import 'package:ebpv2/src/views/ui/auth/welcome/welcome_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeXController controller = Get.put(WelcomeXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: "Welcome", isBackButtonExist: false),
          SliverFillRemaining(
            hasScrollBody: false,
            child: GetBuilder(
                init: controller,
                builder: (_) {
                  return WelcomeView(controller: controller);
                }),
          ),
        ],
      ),
    );
  }
}

class WelcomeView extends StatelessWidget {
  final WelcomeXController controller;

  const WelcomeView({this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            WelcomeCarouselWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}
