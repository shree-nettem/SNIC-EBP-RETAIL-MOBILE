import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: Get.height * 0.125,
            width: Get.width * 0.4,
            decoration: BoxDecoration(
              color: MyColors.PrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_LARGE),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.download_white),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_SMALL,
                  isHeight: true,
                ),
                CustomLabel(
                  title: 'download'.tr,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.125,
            width: Get.width * 0.4,
            decoration: BoxDecoration(
              color: MyColors.PrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_LARGE),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.share_white),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_SMALL,
                  isHeight: true,
                ),
                CustomLabel(
                  title: 'share'.tr,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
