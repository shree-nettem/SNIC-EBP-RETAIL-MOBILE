import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/widgets/ghady_home_saving_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GhadyTabView extends StatelessWidget {
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
                Images.ghady_saving_bg,
              ),
              SvgPicture.asset(
                Images.ghady_saving_home,
              ),
            ],
          ),
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
        GhadyHomeSavingButton(),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        _ghadyItem('learnAboutSNIC'.tr, 0),
        _ghadyItem('learnHowMoneyGrow'.tr, 1),
      ],
    );
  }

  _ghadyItem(String title, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      child: InkWell(
        onTap: () {
          // Get.toNamed(AppRoutes.GHADY_BENEFICIERIES_VIEW);
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
                Flexible(
                  child: CustomLabel(
                    title: title,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
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
