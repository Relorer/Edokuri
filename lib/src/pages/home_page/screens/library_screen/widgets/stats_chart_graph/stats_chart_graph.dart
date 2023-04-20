// 🎯 Dart imports:
import 'dart:collection';

// 🐦 Flutter imports:

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';

class StatsChartGraph extends StatefulWidget {
  const StatsChartGraph({Key? key}) : super(key: key);

  @override
  State<StatsChartGraph> createState() => _StatsChartGraphState();
}

class _StatsChartGraphState extends State<StatsChartGraph> {
  final records = getIt<RecordRepository>().records;

  @override
  Widget build(BuildContext context) {
    List<FlSpot> flSpotList = List.empty(growable: true);
    Map<int, double> map = {};
    for (var record in records) {
      // convert ms to days
      int reviewInterval = record.reviewInterval ~/ 86400000;
      if (!map.containsKey(reviewInterval)) {
        map[reviewInterval] = 1;
      } else {
        map[reviewInterval] = map[reviewInterval]! + 1;
      }
    }
    // sort map by keys (reviewIntervals)
    map = SplayTreeMap<int, double>.from(map, (k1, k2) => k1.compareTo(k2));
    map.forEach((key, value) {
      flSpotList.add(FlSpot(key.toDouble(), value));
    });
    var widgetToReturn = map.length > 2
        ? Opacity(
            opacity: 0.33,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: LineChart(
                LineChartData(
                    minY: 0,
                    minX: 0,
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                          color: const Color(0x00000000),
                          isCurved: true,
                          dotData: FlDotData(show: false),
                          spots: flSpotList,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.white.withOpacity(0.2),
                          ))
                    ]),
              ),
            ),
          )
        : const SizedBox();
    return widgetToReturn;
  }
}
