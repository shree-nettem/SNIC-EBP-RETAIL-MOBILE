import 'dart:collection';

import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DefaultAllocationView extends StatelessWidget {
  final GhadyRetirementDetailsController controller = Get.find();

  DefaultAllocationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          title: 'defaultAllocation'.tr,
          fontSize: 18,
          fontFamily: Constants.FONT_PROXIMA_NOVA,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(
          height: 22,
        ),
        Container(
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: MyColors.GrayColor,
                blurRadius: 12.0,
                offset: Offset(
                  0.0,
                  6.0,
                ),
              ),
            ],
          ),
          child: Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(
                    title: controller.ghadySavingPlanDetails != null
                        ? (controller.ghadySavingPlanDetails.strategy +
                            " " +
                            'strategy'.tr)
                        : "",
                    fontSize: 18,
                    fontFamily: Constants.FONT_PROXIMA_NOVA,
                    fontWeight: FontWeight.w800,
                    color: MyColors.VerticalDividerColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomLabel(
                    title: 'defaultAllocationSubText'.tr,
                    fontSize: 12,
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StackedBar(),
                  // Container(
                  //   width: Get.width,
                  //   height: 21,
                  //   decoration: BoxDecoration(
                  //     color: MyColors.VerticalDividerColor,
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(12),
                  //     ),
                  //     border: Border.all(
                  //       color: Color.fromRGBO(207, 215, 219, 1),
                  //       width: 4,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    itemCount: controller.allocationsDistribution.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = controller.ghadySavingPlanDetails
                          .allocationsDistribution[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Images.rect,
                              color: Utils.getColor(index),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            CustomLabel(
                              title: item.percentage.toString() +
                                  "% " +
                                  item.fundName,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StackedBar extends StatelessWidget {
  final HashMap<int, int> factors = HashMap();
  final GhadyRetirementDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (controller.ghadySavingPlanDetails != null)
      for (int i = 0;
          i < controller.ghadySavingPlanDetails.allocationsDistribution.length;
          i++) {
        var w = Expanded(
          flex: controller
              .ghadySavingPlanDetails.allocationsDistribution[i].percentage,
          child: i == 0
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Utils.getColor(i),
                  ),
                  height: 21,
                )
              : Container(
                  height: 21,
                  color: Utils.getColor(i),
                ),
        );

        widgets.add(w);
      }

    return Container(
      decoration: BoxDecoration(
        color: MyColors.VerticalDividerColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: Color.fromRGBO(207, 215, 219, 1),
          width: 4,
        ),
      ),
      width: Get.width,
      height: 21,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}
