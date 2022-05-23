import 'dart:io';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_bottom_call_options.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/customer_medical_network.dart';

class ContactSupportView extends StatelessWidget {
  ContactSupportView({Key key}) : super(key: key);

  final cellHeight = Get.height * 0.12;
  final cellWidth = Get.width * 0.25;
  HomeXController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.35,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomSpacer(
            value: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    launch(
                        "tel://${_controller.contactInfo.contactTel.toString()}");
                  },
                  child: Container(
                    height: cellHeight,
                    width: cellWidth,
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
                        SvgPicture.asset(Images.call),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_SMALL,
                          isHeight: true,
                        ),
                        CustomLabel(
                          title: 'callUs'.tr,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();

                    if (Platform.isAndroid) {
                      // add the [https]
                      launch(
                          "https://wa.me/${_controller.contactInfo.whatsAppNumber.toString()}"); // new line
                    } else {
                      // add the [https]
                      launch(
                          "https://api.whatsapp.com/send?phone=${_controller.contactInfo.whatsAppNumber.toString()}"); // new line
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: cellHeight,
                    width: cellWidth,
                    decoration: BoxDecoration(
                      color: MyColors.PrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.RADIUS_LARGE),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Images.whatsapp_share,
                          // color: Colors.white,
                        ),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_SMALL,
                          isHeight: true,
                        ),
                        CustomLabel(
                          title: 'whatsApp'.tr,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    launch(
                        "mailto:${_controller.contactInfo.emailSupport.toString()}");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: cellHeight,
                    width: cellWidth,
                    decoration: BoxDecoration(
                      color: MyColors.PrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.RADIUS_LARGE),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.email_share),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_SMALL,
                          isHeight: true,
                        ),
                        CustomLabel(
                          title: 'email'.tr,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    launch(
                        "tel://${_controller.contactInfo.rsaLocal.toString()}");
                  },
                  child: Container(
                    height: cellHeight,
                    width: cellWidth,
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
                        SvgPicture.asset(Images.call),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_SMALL,
                          isHeight: true,
                        ),
                        CustomLabel(
                          title: 'roadsideAssist'.tr,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();

                    showBottomcallOptions(ContactSupport(
                        local: _controller.contactInfo.medNetLocal,
                        international:
                            _controller.contactInfo.medNetInternational));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: cellHeight,
                    width: cellWidth,
                    decoration: BoxDecoration(
                      color: MyColors.PrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.RADIUS_LARGE),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.call),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_SMALL,
                          isHeight: true,
                        ),
                        CustomLabel(
                          title: 'mednet'.tr,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.CONTACT_FORM);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: cellHeight,
                    width: cellWidth,
                    decoration: BoxDecoration(
                      color: MyColors.PrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.RADIUS_LARGE),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.comment),
                        CustomSpacer(
                          value: Dimensions.PADDING_SIZE_SMALL,
                          isHeight: true,
                        ),
                        CustomLabel(
                          title: 'sendFeedback'.tr,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomSpacer(
            value: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ],
      ),
    );
  }
}
