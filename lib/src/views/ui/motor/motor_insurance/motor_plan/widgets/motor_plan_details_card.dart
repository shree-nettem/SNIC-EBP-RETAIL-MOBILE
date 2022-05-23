import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_rich_text.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/policy_benifits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MotorPlanDetailsCardView extends StatelessWidget {
  MotorPalnXController controller = Get.find();

  final int index;

  MotorPlanDetailsCardView({this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          controller.setSelectedPlan(index);
        },
        child: Obx(() {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.all(5.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: controller.selectedIndex.value == index
                    ? MyColors.VerticalDividerColor
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Color(0xffcfd7db), Color(0xffffffff)],
                stops: [0, 1],
                begin: Alignment(0.42, 0.91),
                end: Alignment(-0.42, -0.91),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(0x336f8693),
                    offset: Offset(0, 5),
                    blurRadius: 12,
                    spreadRadius: 0)
              ],
            ),
            // child: Text("current index is $index"),
            child: AutoScrollTag(
              key: ValueKey(index),
              controller: controller.scrollController,
              index: index,
              child: Container(
                padding: controller.isRecommendedVisible
                    ? const EdgeInsets.only(left: 2, right: 2, top: 35.0)
                    : const EdgeInsets.only(left: 2, right: 2, top: 5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomLabel(
                          title: controller.premium.data[index].businessName,
                          fontFamily: Constants.FONT_PROXIMA_NOVA,
                          fontSize: 18,
                        ),
                        // Spacer(),
                        Obx(() => Flexible(
                              child: CustomRichText(
                                  spanText1: "BHD ",
                                  spanText2: controller.premium.data[index]
                                          .hasCalculatePremium.value
                                      ? controller
                                              .premium
                                              .data[index]
                                              .calculatePremiumOutput
                                              .strBasicPremium ??
                                          ""
                                      : controller.premium.data[index]
                                                  .startingFrom !=
                                              null
                                          ? controller
                                              .premium.data[index].startingFrom
                                              .toString()
                                          : controller.premium.data[index]
                                                      .calculatePremiumOutput !=
                                                  null
                                              ? controller
                                                  .premium
                                                  .data[index]
                                                  .calculatePremiumOutput
                                                  .strBasicPremium
                                              : "0"),
                            )),
                      ],
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.premium.data[index].planCovers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: PolicyBenifits(
                                index: index,
                                list: controller
                                    .premium.data[this.index].planCovers),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
