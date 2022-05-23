import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ReviewGraphView extends StatelessWidget {
  ReviewGraphView({Key key}) : super(key: key);
  final List<_ChartData> chartData = <_ChartData>[
    _ChartData(DateTime(2000, 1, 1), 0.1, 0.03, 0.48, 0.23),
    _ChartData(DateTime(2001, 1, 1), 0.81, 0.05, 0.53, 0.17),
    _ChartData(DateTime(2002, 1, 1), 0.91, 0.06, 0.57, 0.17),
    _ChartData(DateTime(2003, 1, 1), 1.00, 0.09, 0.61, 0.20),
    _ChartData(DateTime(2004, 1, 1), 1.19, 0.14, 0.63, 0.23),
    _ChartData(DateTime(2005, 1, 1), 1.47, 0.20, 0.64, 0.36),
    _ChartData(DateTime(2006, 1, 1), 1.74, 0.29, 0.66, 0.43),
    _ChartData(DateTime(2007, 1, 1), 1.98, 0.46, 0.76, 0.52),
    _ChartData(DateTime(2008, 1, 1), 1.99, 0.64, 0.77, 0.72),
    _ChartData(DateTime(2009, 1, 1), 1.70, 0.75, 0.55, 1.29),
    _ChartData(DateTime(2010, 1, 1), 1.48, 1.06, 0.54, 1.38),
    _ChartData(DateTime(2011, 1, 1), 1.38, 1.25, 0.57, 1.82),
    _ChartData(DateTime(2012, 1, 1), 1.66, 1.55, 0.61, 2.16),
    _ChartData(DateTime(2013, 1, 1), 1.66, 1.55, 0.67, 2.51),
    _ChartData(DateTime(2014, 1, 1), 1.67, 1.65, 0.67, 2.61),
    _ChartData(DateTime(2015, 1, 1), 1.98, 1.96, 0.98, 2.93),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfSparkLineChart(
      //Enable the trackball
      trackball:
          SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
      //Enable marker
      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.all,
      data: <double>[1, 5, 7, 13, 7, 5, 11, 5, 3],
    ));

    // return SfCartesianChart(
    //   plotAreaBorderWidth: 0,
    //   title: ChartTitle(text: 'Sales comparision of fruits in a shop'),
    //   legend:
    //       Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
    //   primaryXAxis: DateTimeAxis(
    //       majorGridLines: const MajorGridLines(width: 0),
    //       intervalType: DateTimeIntervalType.years,
    //       dateFormat: DateFormat.y()),
    //   primaryYAxis: NumericAxis(
    //       rangePadding: ChartRangePadding.none,
    //       axisLine: const AxisLine(width: 0),
    //       majorTickLines: const MajorTickLines(size: 0)),
    //   series: _getStackedAreaSeries(),
    //   tooltipBehavior:
    //       TooltipBehavior(enable: true, header: '', canShowMarker: false),
    // );
  }

  List<ChartSeries<_ChartData, DateTime>> _getStackedAreaSeries() {
    return <ChartSeries<_ChartData, DateTime>>[
      StackedArea100Series<_ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.organic,
          name: 'Apple'),
      StackedArea100Series<_ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.fairTrade,
          name: 'Orange'),
      StackedArea100Series<_ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.veg,
          name: 'Pears'),
    ];
  }

  // List<LineSeries<_ChartData, num>> _getDashedLineSeries() {
  //   return <LineSeries<_ChartData, num>>[
  //     LineSeries<_ChartData, num>(
  //         animationDuration: 2500,

  //         /// The property uses to render a line with dashes.
  //         dashArray: <double>[15, 3, 3, 3],
  //         dataSource: chartData,
  //         xValueMapper: (_ChartData sales, _) => sales.x,
  //         yValueMapper: (_ChartData sales, _) => sales.y,
  //         width: 2,
  //         name: 'Singapore',
  //         markerSettings: const MarkerSettings(isVisible: true)),
  //   ];
  // }
}

class _ChartData {
  _ChartData(this.x, this.organic, this.fairTrade, this.veg, this.others);
  final DateTime x;
  final num organic;
  final num fairTrade;
  final num veg;
  final num others;
}
