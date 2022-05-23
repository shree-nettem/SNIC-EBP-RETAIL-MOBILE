import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_saving_beneficiares.dart/saving_beneficiries_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GhadyRetirementHeaderView extends StatelessWidget {
  const GhadyRetirementHeaderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomLabel(
              title: "Ghady Retirement",
              fontSize: 18,
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontWeight: FontWeight.w700,
            ),
            CustomButton(
              title: 'manage'.tr,
              height: 40,
              paddingWidth: 10,
              fontSize: 12,
              width: Get.width * 0.25,
              buttonAction: () {
                Get.toNamed(AppRoutes.GHADY_BENEFICIERIES_VIEW);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        CustomButton(
          title: 'active'.tr,
          width: Get.width * 0.2,
          fontSize: 12,
          height: 26,
          bgColor: MyColors.successGreen,
          buttonAction: () {},
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
