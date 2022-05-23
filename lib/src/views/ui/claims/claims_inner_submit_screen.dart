import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InnerSubmitClaimScreen extends StatelessWidget {
  const InnerSubmitClaimScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SvgPicture.asset(
                Images.insurance_bg,
              ),
              SvgPicture.asset(
                Images.insurance_image,
              ),
            ],
          ),
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
        _claimsItem(
          Images.medical_cross_icon,
          'medicalClaim'.tr,
          0,
        ),
        _claimsItem(
          Images.car_collision,
          'motor_claim'.tr,
          1,
        ),
      ],
    );
  }

  _claimsItem(String icon, String title, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
      child: InkWell(
        onTap: () {
          index == 0
              ? Get.toNamed(AppRoutes.MEDICAL_CLAIM)
              : Get.toNamed(AppRoutes.MOTOR_CLAIM);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 2,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: 25, child: SvgPicture.asset(icon)),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: CustomLabel(
                    title: title,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
