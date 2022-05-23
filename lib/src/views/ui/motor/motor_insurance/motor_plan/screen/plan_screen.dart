import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_horizontal_slider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_rich_text.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculate_premium.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/motor_plan_details_card.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/suppliment_benifits.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/payment_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class PlanScreen extends StatelessWidget {
  MotorPalnXController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return controller.premium != null
        ? Form(
            key: formKey,
            child: Container(
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(bottom: 5),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width * 0.7 + 10,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.premium.data.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: MotorPlanDetailsCardView(index: index),
                                ),
                              );
                            })),
                    Obx(() {
                      return Visibility(
                        visible: controller
                                .premium
                                .data[controller.selectedIndex.value]
                                .recommended
                            ? controller.isRecommendedVisible = true
                            : controller.isRecommendedVisible = false,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 20, right: 10),
                            padding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                            decoration: new BoxDecoration(
                              color: Color(0xff40a2be),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x666f8693),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                    spreadRadius: 0)
                              ],
                            ),
                            child: CustomLabel(
                              title: 'recommended'.tr.capitalize,
                              color: Colors.white,
                              fontFamily: Constants.FONT_PROXIMA_NOVA,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),

                /* Visibility(
            visible: !controller.isPlanSelected ? true : false,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  */ /*    InkWell(
                    onTap: () {
                      motorXController.expansionCardKey[1].currentState.collapse();
                    },
                    child: CustomTextButton(
                      leadingIcon: Icons.keyboard_arrow_left,
                      title: "Back",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      maxLines: 2,
                      color: MyColors.mainBackgroundColor,
                    ),
                  ),
                  Spacer(),*/ /*
                  CustomButton(
                    title: MyString.selectPlanBtnTxt,
                    isActive: false,
                    height: 26,
                    buttonAction: () {
                      controller.setSelectedPlan(controller.pageNo);

                      //motorXController.expansionCardKey[1].currentState.collapse();
                    },
                    bgColor: MyColors.VerticalDividerColor,
                  ),
                ],
              ),
            ),
          ),*/

                // GetBuilder(builder: builder)
                Obx(() {
                  return Column(
                    children: [
                      Visibility(
                        visible: !controller.isPlanSelected ? true : false,
                        child: Center(
                          child: HorizontalCustomalSider(
                            onNextPageTap: () {
                              if (controller.pageNo >= 0 &&
                                  controller.pageNo <
                                      controller.premium.data.length - 1) {
                                controller.pageNo = controller.pageNo + 1;
                                controller.scrollController.scrollToIndex(
                                  controller.pageNo,
                                  preferPosition: AutoScrollPosition.middle,
                                );
                                controller.setSelectedPlan(controller.pageNo);
                                controller
                                    .calculateSupplementaryBenifitsTotal();
                                controller.calculateTotalPremeium();
                                controller.eligibleOption.value = "SELECT";
                                controller.eligibleUpgradeList = [
                                  controller.eligibleOption.value
                                ];
                                controller.eligibleUpgradeList.addAll(controller
                                    .premium
                                    .data[controller.selectedIndex.value]
                                    .eligibleUpgrades
                                    .map((e) => e.label));
                                controller.eligibleOption.value = controller
                                    .premium
                                    .data[controller.selectedIndex.value]
                                    .eligibleUpgrades
                                    .firstWhere((e) =>
                                        e.value ==
                                        controller
                                            .premium
                                            .data[
                                                controller.selectedIndex.value]
                                            .defaultUpgrade)
                                    .label;
                              }

                              // controller.scrollToNextPage();
                            },
                            onPreviousPageTap: () {
                              if (controller.pageNo > 0) {
                                controller.pageNo = controller.pageNo - 1;
                                controller.scrollController.scrollToIndex(
                                  controller.pageNo,
                                  preferPosition: AutoScrollPosition.middle,
                                );
                                controller.setSelectedPlan(controller.pageNo);
                                controller
                                    .calculateSupplementaryBenifitsTotal();
                                controller.calculateTotalPremeium();
                                controller.eligibleOption.value = "SELECT";
                                controller.eligibleUpgradeList = [
                                  controller.eligibleOption.value
                                ];
                                controller.eligibleUpgradeList.addAll(controller
                                    .premium
                                    .data[controller.selectedIndex.value]
                                    .eligibleUpgrades
                                    .map((e) => e.label));
                                controller.eligibleOption.value = controller
                                    .premium
                                    .data[controller.selectedIndex.value]
                                    .eligibleUpgrades
                                    .firstWhere((e) =>
                                        e.value ==
                                        controller
                                            .premium
                                            .data[
                                                controller.selectedIndex.value]
                                            .defaultUpgrade)
                                    .label;
                                // controller.eligibleOption.value =
                              }
                              // controller.scrollToPreviousPage();
                            },
                            pageNo: controller.pageNo,
                            maxCount: controller.premium.data.length,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      controller.premium.data[controller.selectedIndex.value]
                                  .optionalCovers.length >
                              0
                          ? SupplimentBenefits()
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        height: 1,
                        color: MyColors.PrimaryColor.withOpacity(0.3),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, bottom: 10),
                        child: CustomLabel(
                          title: 'rsaAndReplacementOption'.tr,
                          fontFamily: Constants.FONT_PROXIMA_NOVA,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Obx(() {
                          return controller.eligibleOption.value == "SELECT"
                              ? CustomDropDown(
                                  label: controller.eligibleOption.value,
                                  options: controller.eligibleUpgradeList,
                                  onChanged: (val) {
                                    controller.eligibleOption.value = val;
                                    controller.calculateTotalPremeium();
                                    if (controller
                                            .premium
                                            .data[
                                                controller.selectedIndex.value]
                                            .calculatePremiumOutput !=
                                        null)
                                      controller
                                          .premium
                                          .data[controller.selectedIndex.value]
                                          .hasCalculatePremium
                                          .value = false;

                                    // controller.update();
                                  },
                                )
                              : CustomDropDown(
                                  label: controller.eligibleOption.value,
                                  options: controller.eligibleUpgradeList,
                                  onChanged: (val) {
                                    controller.eligibleOption.value = val;
                                    controller.calculateTotalPremeium();
                                    if (controller
                                            .premium
                                            .data[
                                                controller.selectedIndex.value]
                                            .calculatePremiumOutput !=
                                        null)
                                      controller
                                          .premium
                                          .data[controller.selectedIndex.value]
                                          .hasCalculatePremium
                                          .value = false;
                                    // if (controller
                                    //     .premium
                                    //     .data[controller.selectedIndex.value]
                                    //     .hasCalculatePremium
                                    //     .value)
                                    //   controller
                                    //     ..getPlanDetails(
                                    //         paymentMethodCall: false,
                                    //         updateDetails: true,
                                    //         fromCalculatePremiumtn: true);
                                    // controller.update();
                                  },
                                );
                        }),
                      ),
                      Visibility(
                        visible: controller.isPlanSelected ? false : true,
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(5),
                                child: PaymentDetailsScreen(
                                  isDiscountVisilbe: false,
                                )),
                            if (controller
                                .premium
                                .data[controller.selectedIndex.value]
                                .hasCalculatePremium
                                .value)
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                height: 1,
                                color: MyColors.PrimaryColor.withOpacity(0.3),
                              ),
                            if (controller
                                .premium
                                .data[controller.selectedIndex.value]
                                .hasCalculatePremium
                                .value)
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: 'total'.tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomRichText(
                                        spanText1: "BHD",
                                        spanText2:
                                            controller.calculateTotalPremeium())
                                  ],
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              height: 1,
                              color: MyColors.PrimaryColor.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })
              ]),
            ),
          )
        : Container(
            height: 650,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          );
  }
}
