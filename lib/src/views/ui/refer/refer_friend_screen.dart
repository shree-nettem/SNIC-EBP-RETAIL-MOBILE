import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_snackbar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/refer/refer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReferFriendScreen extends StatelessWidget {
  final ReferXController controller = Get.put(ReferXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: MyColors.MainColor,
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(title: "Refer a friend"),
              SliverToBoxAdapter(
                child: ReferFriendView(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ReferFriendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            ReferCardView(),
            ReferChildView(),
          ],
        ),
      ),
    );
  }
}

class ReferCardView extends StatelessWidget {
  ReferCardView();
  final ReferXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
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
          margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_LARGE,
              bottom: Dimensions.PADDING_SIZE_LARGE),
          child: Column(
            children: [
              RepaintBoundary(
                key: controller.qrKey,
                child: Container(
                  color: Colors.white,
                  child: QrImage(
                    data: controller.referralCode,
                    version: QrVersions.auto,
                    size: 100.0,
                  ),
                ),
              ),
              CustomSpacer(value: Dimensions.PADDING_SIZE_SMALL * 2),
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  controller.shareQRImage();
                  // Get.bottomSheet(ShareBottomSheet());
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: SvgPicture.asset(
                                Images.share,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: CustomLabel(
                          title: 'share_qr_code'.tr,
                          color: MyColors.PrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomSpacer(value: Dimensions.PADDING_SIZE_SMALL),
              const Divider(
                color: MyColors.GrayColor,
              ),
              // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: "${controller.referralCode}"));
                  showCustomSnackBar('code_copied'.tr);
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${controller.referralCode}   ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.PrimaryColor,
                        ),
                      ),
                      WidgetSpan(
                        child: SvgPicture.asset(Images.copy),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
      ),
    );
  }
}

class ReferChildView extends StatelessWidget {
  final ReferXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: const Divider(
              color: MyColors.GrayColor,
            ),
          ),
          CustomLabel(
            title: 'my_referrals'.tr,
            color: MyColors.PrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
          CustomLabel(
            title:
                "${controller.numberOfReferrals} Joined SNIC using your link",
            color: MyColors.PrimaryColor,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: const Divider(
              color: MyColors.GrayColor,
            ),
          ),
          CustomLabel(
            title: 'how_it_works'.tr,
            color: MyColors.PrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: MyColors.PrimaryColor,
                size: Dimensions.RADIUS_EXTRA_LARGE,
              ),
              CustomSpacer(
                value: Dimensions.PADDING_SIZE_SMALL,
                isHeight: false,
              ),
              CustomLabel(
                title: 'send_qr_code'.tr,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
          CustomLabel(
            title: 'refer_friends_family'.tr,
            maxLines: null,
            color: MyColors.PrimaryColor,
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: MyColors.PrimaryColor,
                size: Dimensions.RADIUS_EXTRA_LARGE,
              ),
              CustomSpacer(
                value: Dimensions.PADDING_SIZE_SMALL,
                isHeight: false,
              ),
              CustomLabel(
                title: 'earn_points'.tr,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
          CustomLabel(
            title: 'earn_points_every_referral'.tr,
            maxLines: 2,
            color: MyColors.PrimaryColor,
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
        ],
      ),
    );
  }
}
