import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ghady_latest_activity_item.view.dart';

class GhadyLatestActivityView extends StatelessWidget {
  final GhadyRetirementDetailsController controller = Get.find();

  GhadyLatestActivityView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          title: 'latestActivity'.tr,
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
              margin: const EdgeInsets.all(28),
              child: Column(
                children: [
                  controller.ghadySavingPlanDetails != null
                      ? ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.ghadySavingPlanDetails
                                      .activities.length >
                                  controller.activityCount
                              ? controller.activityCount
                              : controller
                                  .ghadySavingPlanDetails.activities.length,
                          itemBuilder: (context, index) {
                            var item = controller
                                .ghadySavingPlanDetails?.activities[index];
                            return GhadyLatestActivityItemView(
                                item.name, "BHD ${item.amount}", item.date);
                          })
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 6,
                  ),
                  Visibility(
                    visible: controller.ghadySavingPlanDetails != null &&
                            controller
                                    .ghadySavingPlanDetails.activities.length >
                                5
                        ? true
                        : false,
                    child: GestureDetector(
                      onTap: () {
                        controller.loadActivityMore();
                      },
                      child: CustomLabel(
                        title: controller.ghadySavingPlanDetails != null &&
                                controller.ghadySavingPlanDetails.activities
                                        .length <
                                    controller.activityCount
                            ? 'view_less'.tr
                            : 'view_more'.tr,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
