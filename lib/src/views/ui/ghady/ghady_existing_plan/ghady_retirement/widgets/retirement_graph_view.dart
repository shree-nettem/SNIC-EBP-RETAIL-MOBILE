import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RetirementGraphView extends StatelessWidget {
  final GhadyRetirementDetailsController controller = Get.find();
  RetirementGraphView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.8,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomLabel(
                title: "",
                fontSize: 14,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      opposedPosition: true,
                    ),
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<SalesData, String>(
                          color: Color.fromRGBO(62, 216, 139, 1),
                          dataSource: controller.primaryPolicyChartData,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            color: Color.fromRGBO(62, 216, 139, 1),
                          ),
                          xValueMapper: (SalesData sales, _) =>
                              sales.year.toString(),
                          yValueMapper: (SalesData sales, _) => sales.sales),
                      LineSeries<SalesData, String>(
                          color: Color.fromRGBO(248, 213, 41, 1),
                          dataSource: controller.secondaryContributionChartData,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            color: Color.fromRGBO(248, 213, 41, 1),
                          ),
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales)
                    ]),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 216, 139, 1),
                        shape: BoxShape.circle),
                  ),
                  CustomLabel(
                    title: 'policy_value'.tr,
                    fontSize: 12,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 213, 41, 1),
                        shape: BoxShape.circle),
                  ),
                  CustomLabel(
                    title: 'contributionInvested'.tr,
                    fontSize: 12,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
