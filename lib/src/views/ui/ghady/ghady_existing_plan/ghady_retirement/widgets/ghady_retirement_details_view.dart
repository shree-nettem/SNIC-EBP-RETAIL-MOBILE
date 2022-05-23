import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ghady_retirement_details_item_view.dart';

class GhadyRetirementDetailsView extends StatelessWidget {
  GhadyRetirementDetailsView({Key key}) : super(key: key);
  final GhadyRetirementDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var currency = controller.ghadySavingPlanDetails?.currency ?? "BHD";
    var nextPaymentDate =
        controller.ghadySavingPlanDetails?.nextPaymentDueDate ?? " ";
    num lastRate = controller.graphHistoryList.length > 0
        ? controller.graphHistoryList[controller.graphHistoryList.length - 1] !=
                null
            ? controller
                .graphHistoryList[controller.graphHistoryList.length - 1].rate
            : 0
        : 0;

    var monthlyContribution = 0;
    var finalTerm = "";

    if (controller.ghadySavingPlanDetails != null) {
      for (var item in controller.ghadySavingPlanDetails?.summary) {
        controller.policyValue += item.amount * lastRate;
      }

      monthlyContribution = controller.ghadySavingPlanDetails.contribution;
      var startDate = controller.ghadySavingPlanDetails.startDate;
      var term = controller.ghadySavingPlanDetails.term;
      var endDate = Utils.convertStringDateToDate(startDate);

      var newDate = endDate.add(Duration(days: 366 * term.toInt()));

      // var endDate = Utils.convertStringDateToDate(startDate);
      finalTerm = Utils.getOnlyDate(startDate) +
          ' - ' +
          Utils.getOnlyDate(newDate.toString());

      print(finalTerm);
    }

    return Container(
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
            children: [
              GhadyRetirementDetailsItemView(
                  'monthly'.tr, "$currency $monthlyContribution"),
              GhadyRetirementDetailsItemView('term'.tr, "$finalTerm"),
              GhadyRetirementDetailsItemView(
                  'next_payment'.tr, "$nextPaymentDate"),
              GhadyRetirementDetailsItemView('policy_value'.tr,
                  "${controller.policyValue.toStringAsFixed(2)} $currency "),
              GhadyRetirementDetailsItemView('total_invested'.tr,
                  "${controller.contribution.toStringAsFixed(2)} $currency "),
            ],
          ),
        ),
      ),
    );
  }
}
