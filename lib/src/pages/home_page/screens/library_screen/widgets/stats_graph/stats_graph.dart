// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/date_controller/date_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/datetime_extensions.dart';
import 'package:edokuri/src/core/utils/random_utils.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/stats_graph/stats_graph_painter.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class StatsGraph extends StatefulWidget {
  const StatsGraph({Key? key}) : super(key: key);

  @override
  State<StatsGraph> createState() => _StatsGraphState();
}

class _StatsGraphState extends State<StatsGraph> {
  final Random random = Random();
  final DateController dateController = getIt<DateController>();

  late List<double> placeholder;
  Offset? pressedPosition;

  @override
  void initState() {
    super.initState();
    placeholder = Iterable<int>.generate(7)
        .map((e) => doubleInRange(random, 0.1, 1))
        .toList();
  }

  int _getNewKnownRecords(DateTime day) {
    return getIt<KnownRecordsRepository>().countForDay(day);
  }

  int _getNewSavedRecords(Iterable<Record> records, DateTime day) {
    return records
        .where((element) => (element.created.isSameDate(day) ||
            element.translations.any(
                (element) => element.selectionDate?.isSameDate(day) ?? false)))
        .length;
  }

  int _getReviewedRecords(Iterable<Record> records, DateTime day) {
    return records
        .where((element) => (element.lastReview.isSameDate(day)))
        .length;
  }

  void _setPressedPosition(Offset? offset) {
    setState(() {
      pressedPosition = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: GestureDetector(
                  onTapDown: ((details) =>
                      _setPressedPosition(details.globalPosition)),
                  onTapUp: ((details) => _setPressedPosition(null)),
                  onTapCancel: (() => _setPressedPosition(null)),
                  child: Observer(builder: (_) {
                    final recordRepository = getIt<RecordRepository>();
                    final graphData = GraphData([
                      ...Iterable<int>.generate(7)
                          .map((e) {
                            final date = dateController
                                .now()
                                .subtract(Duration(days: e));
                            return GraphDayData(date,
                                newKnownRecords: _getNewKnownRecords(date),
                                newSavedRecords: _getNewSavedRecords(
                                    recordRepository.records, date),
                                reviewedWords: _getReviewedRecords(
                                    recordRepository.records, date));
                          })
                          .toList()
                          .reversed
                    ]);
                    return CustomPaint(
                        painter: StatsGraphPainter(
                            context: context,
                            graphData: graphData,
                            placeholder: placeholder,
                            pressedPosition: pressedPosition));
                  })))),
    );
  }
}
