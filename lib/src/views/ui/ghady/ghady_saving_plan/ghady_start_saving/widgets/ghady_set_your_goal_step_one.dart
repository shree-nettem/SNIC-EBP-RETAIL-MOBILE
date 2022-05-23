import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/ghady_set_your_goal_controller.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/widgets/ghady_set_your_goal_step_three.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/widgets/ghady_set_your_goal_step_two_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetYourGoal extends StatelessWidget {
  SetYourGoal({Key key}) : super(key: key);
  final GhadySetYourGoalXController _controller =
      Get.put(GhadySetYourGoalXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return !_controller.alreadyExistsRetirmetPlan
              ? SetYourGoalCompletionView()
              : _controller.currentStep == 1
                  ? SetYourGoalStepOne()
                  : _controller.currentStep == 2
                      ? SetYourGoalStepTwoView()
                      : GhadySetYourGoalStepThree();
        });
  }
}

class SetYourGoalStepOne extends StatelessWidget {
  SetYourGoalStepOne({Key key}) : super(key: key);
  final GhadySetYourGoalXController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 2,
                color: MyColors.PrimaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLabel(
                      title: 'iWantToSaveFor'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomRadioButton(
                      text: 'retirment'.tr,
                      value: _controller.selectedGoal[0],
                      onTap: () {
                        _controller.updateRadioButton(0);
                      },
                    ),
                    CustomRadioButton(
                      text: 'education'.tr,
                      value: _controller.selectedGoal[1],
                      onTap: () {
                        _controller.updateRadioButton(1);
                      },
                    ),
                    CustomRadioButton(
                      text: 'customGoal'.tr,
                      value: _controller.selectedGoal[2],
                      onTap: () {
                        _controller.updateRadioButton(2);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  _controller.changeCurrentStep(step: 2);
                },
                child: CustomBackNextutton(
                  isBackButton: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class GhadySetYourGoalStepSuccess extends StatelessWidget {
  const GhadySetYourGoalStepSuccess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
