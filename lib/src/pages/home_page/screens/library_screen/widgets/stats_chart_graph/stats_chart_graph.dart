// 🎯 Dart imports:
import 'dart:collection';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class StatsChartGraph extends StatefulWidget {
  const StatsChartGraph({Key? key}) : super(key: key);

  @override
  State<StatsChartGraph> createState() => _StatsChartGraphState();
}

class _StatsChartGraphState extends State<StatsChartGraph> {
  final records = getIt<RecordRepository>().records;

  Map<int, double> calculateCumulativePoints(Map<int, double> mapPoints) {
    double cumulativePoints = 0;
    Map<int, double> cumulativePointsMap = {};
    mapPoints.forEach((key, value) {
      cumulativePoints += value;
      cumulativePointsMap[key] = cumulativePoints;
    });
    return cumulativePointsMap;
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> flSpotListCalculate = List.empty(growable: true);
    List<FlSpot> flSpotList = List.empty(growable: true);
    Map<int, double> mapPoints = {};
    for (var record in records) {
      // convert ms to days
      int reviewInterval = record.reviewInterval ~/ 86400000;
      if (!mapPoints.containsKey(reviewInterval)) {
        mapPoints[reviewInterval] = 1;
      } else {
        mapPoints[reviewInterval] = mapPoints[reviewInterval]! + 1;
      }
    }
    // sort map by keys (reviewIntervals)
    mapPoints =
        SplayTreeMap<int, double>.from(mapPoints, (k1, k2) => k1.compareTo(k2));
    mapPoints.forEach((key, value) {
      flSpotList.add(FlSpot(key.toDouble(), value));
    });
    var show = mapPoints.length > 2;
    if (show) {
      show = false;
      var last = mapPoints.values.first;
      for (var element in mapPoints.values) {
        if (element != last) {
          show = true;
          break;
        }
      }
    }

    mapPoints = calculateCumulativePoints(mapPoints);
    mapPoints.forEach((key, value) {
      flSpotListCalculate.add(FlSpot(key.toDouble(), value));
    });
    return Padding(
      padding: const EdgeInsets.only(top: defaultMargin),
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              LineChart(
                LineChartData(
                    minY: 0,
                    minX: 0,
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                          color: Colors.transparent,
                          isStepLineChart: true,
                          dotData: FlDotData(show: false),
                          spots: flSpotList,
                          show: show,
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color.fromRGBO(50, 56, 72, 1),
                          ))
                    ]),
              ),
              LineChart(
                LineChartData(
                    minY: 0,
                    minX: 0,
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        barWidth: 4,
                        curveSmoothness: 0.1,
                        color: const Color.fromRGBO(67, 66, 60, 1),
                        isCurved: true,
                        dotData: FlDotData(show: false),
                        spots: flSpotListCalculate,
                        show: show,
                      )
                    ]),
              ),
            ],
          )),
    );
  }
}
