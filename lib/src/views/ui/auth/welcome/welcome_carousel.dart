import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/auth/welcome/welcome_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WelcomeCarouselWidget extends StatelessWidget {
  final WelcomeXController controller;

  const WelcomeCarouselWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 54),
        VisibilityDetector(
          key: Key('AUTO_PLAY'),
          onVisibilityChanged: (visibilityInfo) {
            controller.autoPlaySlider(visibilityInfo.visibleFraction);
          },
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: controller.autoPlay,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 5),
              onPageChanged: (index, reason) {
                controller.changed(index);
              },
            ),
            items: controller.imgList
                .map(
                  (item) => Container(
                    child: SvgPicture.asset(
                      item,
                      fit: BoxFit.cover,
                      width: Get.width,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 60),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 54),
          child: CustomLabel(
            title:
                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed ",
            maxLines: 3,
            height: 1.4,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.imgList.map((item) {
            int index = controller.imgList.indexOf(item);
            return Container(
              width: controller.currentPos == index ? 6.0 : 6.0,
              height: controller.currentPos == index ? 6.0 : 6.0,
              margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: controller.currentPos == index
                      ? MyColors.PrimaryColor
                      : MyColors.IndicatorColor,
                  style: BorderStyle.solid,
                ),
                color: controller.currentPos == index
                    ? MyColors.PrimaryColor
                    : MyColors.IndicatorColor,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 80),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 54),
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.LOGIN);
            },
            child: CustomLabel(
              title: controller.currentPos == 3 ? "Get Started" : "Skip",
              color: controller.currentPos == 3
                  ? MyColors.PrimaryColor
                  : Color.fromRGBO(64, 162, 190, 1),
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontWeight: FontWeight.w600,
              fontSize: controller.currentPos == 3 ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }
}
