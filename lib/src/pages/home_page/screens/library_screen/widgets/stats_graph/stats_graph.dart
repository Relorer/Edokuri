import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/core/utils/random_utils.dart';
import 'package:freader/src/models/graph.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/stats_graph/stats_graph_painter.dart';
import 'package:freader/src/theme/theme_consts.dart';

import 'package:provider/provider.dart';

class StatsGraph extends StatefulWidget {
  const StatsGraph({Key? key}) : super(key: key);

  @override
  State<StatsGraph> createState() => _StatsGraphState();
}

class _StatsGraphState extends State<StatsGraph> {
  final Random random = Random();

  late List<double> placeholder;
  Offset? pressedPosition;

  @override
  void initState() {
    super.initState();
    placeholder = Iterable<int>.generate(7)
        .map((e) => doubleInRange(random, 0.1, 1))
        .toList();
  }

  int _getNewKnownRecords(Iterable<Record> records, DateTime day) {
    return records
        .where(
            (element) => element.creationDate.isSameDate(day) && element.known)
        .length;
  }

  int _getNewSavedRecords(Iterable<Record> records, DateTime day) {
    return records
        .where((element) =>
            (element.creationDate.isSameDate(day) ||
                element.translations.any((element) =>
                    element.selectionDate?.isSameDate(day) ?? false)) &&
            !element.known)
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
                    final db = context.read<DBController>();
                    final graphData = GraphData([
                      ...Iterable<int>.generate(7)
                          .map((e) {
                            final date =
                                DateTime.now().subtract(Duration(days: e));
                            return GraphDayData(date,
                                newKnownRecords:
                                    _getNewKnownRecords(db.records, date),
                                newSavedRecords:
                                    _getNewSavedRecords(db.records, date));
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
