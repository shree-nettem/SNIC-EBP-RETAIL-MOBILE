import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_expandabletile.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/payment/ghady_payment_screen.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/select_your_strategy/select_your_strategy_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/widgets/ghady_set_your_goal_step_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ghady_start_saving_tabone_controller.dart';
import 'review_and_adjust/graph_review_ad_adjust_view.dart';

class GhadyStartSavingTabOne extends StatelessWidget {
  GhadyStartSavingTabOne({Key key}) : super(key: key);
  final GhadyStartSavingTaboneXController _controller =
      Get.put(GhadyStartSavingTaboneXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return ListView(
            children: [
              CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
              IgnorePointer(
                ignoring: false,
                child: Opacity(
                  opacity: 1,
                  child: CustomExpandableTile(
                    expansionCardKey: _controller.expansionCardKey[0],
                    classview: SetYourGoal(),
                    title: '1',
                    name: 'setYourGoal'.tr,
                    isButtonVisible: true,
                    isStatusVisible: false,
                    onExpansionChanged: (val) {},
                    buttonText: 'start'.tr,
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: false,
                child: Opacity(
                  opacity: 1,
                  child: CustomExpandableTile(
                    expansionCardKey: _controller.expansionCardKey[1],
                    classview: SelectYourStrategyStepTwo(),
                    title: '2',
                    name: 'selectYourStrategy'.tr,
                    isButtonVisible: true,
                    buttonText: 'start'.tr,
                    isStatusVisible: false,
                    onExpansionChanged: (val) {},
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: false,
                child: Opacity(
                  opacity: 1,
                  child: CustomExpandableTile(
                    expansionCardKey: _controller.expansionCardKey[2],
                    classview: ReviewAndAdjustEditStepTwo(),
                    title: '3',
                    name: 'reviewAndadjust'.tr,
                    isButtonVisible: true,
                    buttonText: 'start'.tr,
                    isStatusVisible: false,
                    onExpansionChanged: (val) {},
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: false,
                child: Opacity(
                  opacity: 1,
                  child: CustomExpandableTile(
                    expansionCardKey: _controller.expansionCardKey[3],
                    classview: GhadyPaymentView(),
                    title: '4',
                    name: 'payment'.tr,
                    isButtonVisible: true,
                    buttonText: 'start'.tr,
                    isStatusVisible: false,
                    onExpansionChanged: (val) {},
                  ),
                ),
              ),
            ],
          );
        });
  }
}
