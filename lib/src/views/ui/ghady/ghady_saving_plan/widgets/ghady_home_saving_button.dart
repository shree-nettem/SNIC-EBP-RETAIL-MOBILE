import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GhadyHomeSavingButton extends StatelessWidget {
  const GhadyHomeSavingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.GHADY_START_SAVING_HOME);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        margin: EdgeInsets.symmetric(horizontal: 32),
        decoration: new BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF000252),
              const Color(0xFF40a2be),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0x336f8693),
                offset: Offset(0, 5),
                blurRadius: 12,
                spreadRadius: 0)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(
                    title: 'startSaving'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  CustomLabel(
                    title: 'secureWithGhady'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
