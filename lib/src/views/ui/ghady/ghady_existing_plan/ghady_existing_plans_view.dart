import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_existing_request_controller.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_existing_request_model.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/widgets/ghady_retirement_item_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/widgets/ghady_title_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_saving_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GhadyExistingPlansView extends StatelessWidget {
  final GhadyExistingRequestController controller =
      Get.put(GhadyExistingRequestController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.ghadyRequestList.length > 0
                ? Expanded(
                    flex: 1,
                    child: GhadyRetirementPlanView(),
                  )
                : NoExistingPlansView(),
            const SizedBox(
              height: 18,
            ),
          ],
        );
      },
    );
  }
}

/* YOU DONT HAVE EXISTING PLANS VIEW */
class NoExistingPlansView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomLabel(
            title: 'noExistingPlans'.tr,
            maxLines: 2,
            fontSize: 16,
            fontFamily: Constants.FONT_SF_UI_TEXT_MEDIUM,
          ),
          const SizedBox(
            height: 18,
          ),
          // CustomButton(
          //   title: 'startNewPlan'.tr,
          //   height: 40,
          //   paddingWidth: 10,
          //   fontSize: 12,
          //   width: Get.width * 0.65,
          //   buttonAction: () {
          //     GhadySavingHomeController tabController = Get.find();
          //     tabController.tabController.animateTo(0);
          //   },
          // ),
        ],
      ),
    );
  }
}

/* WHEN THERE IS EXISTING PLANS */
class GhadyRetirementPlanView extends StatelessWidget {
  final GhadyExistingRequestController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              scrollDirection: Axis.vertical,
              itemCount: controller.ghadyRequestList.length,
              itemBuilder: (BuildContext context, int index) {
                GhadyExistingRequestModel item =
                    controller.ghadyRequestList[index];
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
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
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.GHADY_RETIREMENT_DETAILS,
                              arguments: {"ghady_existing_plan": item});
                        },
                        child: Card(
                          shadowColor: MyColors.GrayColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            padding: const EdgeInsets.all(26),
                            child: Column(
                              children: [
                                GhadyTitleView(Images.ghady_insurance,
                                    'ghady_retirement'.tr, "active".tr),
                                const SizedBox(
                                  height: 16,
                                ),
                                GhadyRetirementItemView(
                                    'goal'.tr, "${item.goal} BHD"),
                                GhadyRetirementItemView(
                                    'term'.tr, "${item.term} Years"),
                                GhadyRetirementItemView(
                                    'strategy'.tr, "${item.strategy.toInt()}"),
                                GhadyRetirementItemView('monthly'.tr,
                                    "${item.frequencyAmount.toInt()} BHD"),
                                GhadyRetirementItemView('lumpsum'.tr,
                                    "${item.lumpsum.toInt()} BHD"),
                                CustomSpacer(
                                    value: Dimensions.PADDING_SIZE_SMALL),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'viewDetails'.tr,
                                        style: TextStyle(
                                          color: MyColors.mainBackgroundColor,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14,
                                              color:
                                                  MyColors.mainBackgroundColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    index + 1 == controller.ghadyRequestList.length
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              // CustomButton(
                              //   title: 'startNewPlan'.tr,
                              //   height: 40,
                              //   paddingWidth: 10,
                              //   fontSize: 12,
                              //   width: Get.width * 0.65,
                              //   buttonAction: () {
                              //     GhadySavingHomeController tabController =
                              //         Get.find();
                              //     tabController.tabController.animateTo(0);
                              //   },
                              // ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
