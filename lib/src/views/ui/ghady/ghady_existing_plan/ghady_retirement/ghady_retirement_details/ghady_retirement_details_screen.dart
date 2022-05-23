import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/widgets/current_value_history_dropdown_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/widgets/ghady_latest_activity_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/widgets/ghady_retirement_header_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/default_allocation_view.dart';
import '../widgets/ghady_retirement_details_view.dart';
import '../widgets/portfolio_summary_view.dart';
import '../widgets/retirement_graph_view.dart';

class GhadyRetirementDetailsScreen extends StatelessWidget {
  GhadyRetirementDetailsScreen({Key key}) : super(key: key);
  final GhadyRetirementDetailsController controller =
      Get.put(GhadyRetirementDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: "Ghady Saving Plan"),
          SliverToBoxAdapter(
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return SingleChildScrollView(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: ghadySavingPlanView(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget ghadySavingPlanView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GhadyRetirementHeaderView(),
        GhadyRetirementDetailsView(),
        const SizedBox(
          height: 24,
        ),
        CurrentValueHistoryDropDownView(),
        const SizedBox(
          height: 16,
        ),
        RetirementGraphView(),
        const SizedBox(
          height: 36,
        ),
        GhadyLatestActivityView(),
        const SizedBox(
          height: 36,
        ),
        DefaultAllocationView(),
        const SizedBox(
          height: 36,
        ),
        PortfolioSummaryView(),
      ],
    );
  }
}
