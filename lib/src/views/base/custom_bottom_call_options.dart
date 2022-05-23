import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/customer_medical_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void showBottomcallOptions(ContactSupport contactSupport) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: Get.context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),

            // height: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: GetBuilder<LocalizationController>(
                  builder: (localizationController) => Wrap(
                        children: <Widget>[
                          new ListTile(
                            title: CustomLabel(
                                title: localizationController
                                            .locale.languageCode ==
                                        'en'
                                    ? "${"local".tr}: ${contactSupport.local}"
                                    : "${"local".tr}: ${contactSupport.local}"),
                            onTap: () {
                              Get.back();
                              launch("tel://${contactSupport.local}");
                            },
                          ),
                          new ListTile(
                            title: CustomLabel(
                                title: localizationController
                                            .locale.languageCode ==
                                        'en'
                                    ? "${"international".tr}: ${contactSupport.international}"
                                    : "${"international".tr}:  ${contactSupport.international.split(' ').reversed.join('').replaceFirst("+", " ")} +"),
                            onTap: () {
                              Get.back();
                              launch(
                                  "tel://${contactSupport.international.replaceAll(" ", "")}");
                            },
                          ),
                        ],
                      )),
            ),
          ),
        ),
      );
    },
  );
}
