import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ghady_portfolio_item_view.dart';

class PortfolioSummaryView extends StatelessWidget {
  final GhadyRetirementDetailsController controller = Get.find();

  PortfolioSummaryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          title: 'portfolioSummary'.tr,
          fontSize: 18,
          fontFamily: Constants.FONT_PROXIMA_NOVA,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(
          height: 4,
        ),
        CustomLabel(
          title: 'currencyInUSD'.tr,
          fontSize: 12,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
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
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.ghadySavingPlanDetails?.summary?.length ?? 0,
                    itemBuilder: (context, index) {
                      var item =
                          controller.ghadySavingPlanDetails.summary[index];
                      return GhadyPortfolioItemView(
                          item.fundName,
                          item.price.toString(),
                          item.units.toString(),
                          item.amount.toString());
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
