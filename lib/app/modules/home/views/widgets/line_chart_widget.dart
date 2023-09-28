import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_money/app/modules/home/controllers/home_controller.dart';
import 'package:my_money/app/utils/app_color.dart';

class LineChartWidget extends GetView<HomeController> {
  const LineChartWidget({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.expenseSpots.isNotEmpty ||
            controller.incomeSpots.isNotEmpty) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: LineChart(
              sampleData1,
            ),
          );
        } else {
          return Center(
            child: Text(
              'Data Kosong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      },
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey.withOpacity(0.2),
        ),
      );

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.white,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Rp 0';
        break;
      case 250000:
        text = 'Rp 250.000';
        break;
      case 500000:
        text = 'Rp 500.000';
        break;
      case 750000:
        text = 'Rp 750.000';
        break;
      case 1000000:
        text = 'Rp 1.000.000';
        break;
      case 1250000:
        text = 'Rp 1.250.000';
        break;
      case 1500000:
        text = 'Rp 1.500.000';
        break;
      case 1750000:
        text = 'Rp 1.750.000';
        break;
      case 2000000:
        text = 'Rp 2.000.000';
        break;
      case 2250000:
        text = 'Rp 2.250.000';
        break;
      case 2500000:
        text = 'Rp 2.500.000';
        break;
      case 2750000:
        text = 'Rp 2.750.000';
        break;
      case 3000000:
        text = 'Rp 3.000.000';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 250000,
        reservedSize: 100,
      );
  
  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        value.toInt().toString(),
        style: style,
      ),
    );
  }

   FlGridData get gridData => const FlGridData(
    show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: AppColor.primaryColor.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: AppColor.contentColorRed,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: controller.expenseSpots,
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        color: AppColor.contentColorGreen,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColor.contentColorRed.withOpacity(0),
        ),
        spots: controller.incomeSpots,
      );
}
