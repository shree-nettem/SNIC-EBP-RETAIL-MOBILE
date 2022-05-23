import 'dart:io';

import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/home/home_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/contact_deatils_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppDeepLinkView extends StatelessWidget {
  ContactDeatilsController controller = Get.put(ContactDeatilsController());
  HomeXController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          CustomLabel(
            title: 'customerServiceMsg'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              if (Platform.isAndroid) {
                // add the [https]
                launch(
                    "https://wa.me/${homeController.contactInfo.whatsAppNumber.toString()}"); // new line
              } else {
                // add the [https]
                launch(
                    "https://api.whatsapp.com/send?phone=${homeController.contactInfo.whatsAppNumber.toString()}"); // new line
              }
              // controller.getContactDetails('WhatsApp');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.whatsapplogo,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomLabel(
                  title: 'whatsApp'.tr,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  underLine: true,
                ),
              ],
            ),
          ),
        ]));
  }
}
