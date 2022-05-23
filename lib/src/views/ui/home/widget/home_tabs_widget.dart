import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeTabsWidget extends StatelessWidget {
  const HomeTabsWidget(this.title, this.image, this.nav);

  final String title, image, nav;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(nav);
      },
      child: Container(
        margin: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  margin: const EdgeInsets.only(
                      right: Dimensions.PADDING_SIZE_DEFAULT),
                  child: SvgPicture.asset(image),
                ),
                addHorizontalWidth(8.0),
                CustomLabel(
                  title: title,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
