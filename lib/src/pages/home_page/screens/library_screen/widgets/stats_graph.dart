import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/graph.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

import 'package:path_drawing/path_drawing.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class StatsGraph extends StatelessWidget {
  final Random random = Random();

  StatsGraph({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final db = context.read<DBController>();

    final graphData = GraphData([
      ...Iterable<int>.generate(7)
          .map((e) {
            final date = DateTime.now().subtract(Duration(days: e));
            return GraphDayData(date,
                newKnownRecords: _getNewKnownRecords(db.records, date),
                newSavedRecords: _getNewSavedRecords(db.records, date));
          })
          .toList()
          .reversed
    ]);

    return Expanded(
      child: SizedBox.expand(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: CanvasTouchDetector(
            gesturesToOverride: [GestureType.onTapDown],
            builder: (context) => CustomPaint(
                painter: _Graph(
                    context,
                    graphData,
                    Iterable<int>.generate(7)
                        .map((e) => random.nextDouble())
                        .toList()))),
      )),
    );
  }
}

class _Graph extends CustomPainter {
  final Map<int, String> weekdayName = {
    1: "MO",
    2: "TU",
    3: "WE",
    4: "TH",
    5: "FR",
    6: "SA",
    7: "SU"
  };

  final BuildContext context;
  final GraphData data;
  final List<double> placeholder;

  late Iterable<int> recordsByDays;
  late double avg;
  late int maxValue;
  late TextStyle graphWeekdayStyle;

  late double columnNameHeight;

  _Graph(this.context, this.data, this.placeholder) {
    recordsByDays = data.days
        .map((e) => e.newKnownRecords + e.newSavedRecords + e.reviewedWords);
    avg = recordsByDays.isNotEmpty
        ? recordsByDays.reduce((a, b) => a + b) / data.days.length
        : 0;
    maxValue = recordsByDays.isNotEmpty ? recordsByDays.reduce(max) : 0;
    graphWeekdayStyle = Theme.of(context).graphWeekdayStyle;

    columnNameHeight =
        _getTextPainterGraphWeekday(weekdayName[1]!, graphWeekdayStyle)
                .size
                .height +
            defaultMargin;
  }

  TextPainter _getTextPainterGraphWeekday(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height),
        Paint()..color = Colors.transparent);

    final graphHeight = size.height - columnNameHeight;

    const edge = defaultMargin;
    final columnCount = data.days.length;
    final offsetCount = columnCount - 1;
    const columnOffsetRatio = .7;

    final columnWidth = (size.width - edge * 2) /
        (columnCount + offsetCount * columnOffsetRatio);
    final offsetBetween =
        (size.width - columnCount * columnWidth - edge * 2) / offsetCount;

    for (var i = 0; i < columnCount; i++) {
      final x1 = i * columnWidth + offsetBetween * i + edge;
      final x2 = x1 + columnWidth;

      _drawColumn(canvas, x1, doubleDefaultMargin, x2,
          graphHeight - defaultMargin, data.days[i], placeholder[i]);

      final columnNameStyle = i == columnCount - 1
          ? graphWeekdayStyle.copyWith(color: Colors.white)
          : graphWeekdayStyle;
      _drawColumnName(canvas, weekdayName[data.days[i].date.weekday]!,
          x1 + columnWidth / 2, size.height, columnNameStyle);
    }

    _drawGrid(canvas, Size(size.width, size.height - columnNameHeight));
  }

  _drawColumnName(
      Canvas canvas, String name, double x, double y, TextStyle style) {
    final namePainter = _getTextPainterGraphWeekday(name, style);
    final offset =
        Offset(x - namePainter.size.width / 2, y - namePainter.size.height);

    namePainter.paint(canvas, offset);
  }

  _drawColumn(Canvas canvas, double left, double top, double right,
      double bottom, GraphDayData day, double placeholder) {
    final paint = Paint();

    final height = bottom - top;

    if (maxValue == 0 ||
        day.newKnownRecords + day.newSavedRecords + day.reviewedWords == 0) {
      final columnHeight = placeholder * height;
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            left,
            columnHeight,
            right,
            bottom,
          ),
          paint..color = Theme.of(context).paleElementColor);

      _roundColumns(canvas, left, columnHeight, right, bottom);
    } else {
      final newSavedWordsY1 = bottom - day.newSavedRecords / maxValue * height;
      final newSavedWordsY2 = bottom;

      final reviewedWordsY1 =
          newSavedWordsY1 - day.reviewedWords / maxValue * height;
      final reviewedWordsY2 = newSavedWordsY1;

      final newKnownWordsY1 =
          reviewedWordsY1 - day.newKnownRecords / maxValue * height;
      final newKnownWordsY2 = reviewedWordsY1;

      //newKnownWords
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          left,
          newKnownWordsY1,
          right,
          newKnownWordsY2,
        ),
        paint..color = white,
      );

      //reviewedWords
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            left,
            reviewedWordsY1,
            right,
            reviewedWordsY2,
          ),
          paint..color = unknownWord);

      //newSavedWords
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            left,
            newSavedWordsY1,
            right,
            newSavedWordsY2,
          ),
          paint..color = savedWord);

      var touchyCanvas = TouchyCanvas(context, canvas);
      touchyCanvas.drawRRect(
        RRect.fromLTRBAndCorners(
          left,
          newKnownWordsY1,
          right,
          newKnownWordsY2,
        ),
        paint..color = white,
        onTapDown: (details) {
          print(details.globalPosition);
        },
      );

      _roundColumns(canvas, left, newKnownWordsY1, right, bottom);
    }
  }

  _roundColumns(
      Canvas canvas, double left, double top, double right, double bottom) {
    final roundingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = defaultRadius
      ..color = darkGray;

    const radius = Radius.circular(defaultRadius);

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
            left - defaultRadius / 2,
            top - defaultRadius / 2,
            right + defaultRadius / 2,
            bottom + defaultRadius / 2,
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
            topRight: radius),
        roundingPaint);
  }

  _drawGrid(Canvas canvas, Size size) {
    final height = size.height;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = paleElement.withOpacity(0.15);

    _drawHorizontalLine(canvas, size, 0, paint);
    _drawHorizontalDashPath(
        canvas, size, height - avg / maxValue * height, paint);
    _drawHorizontalLine(canvas, size, height, paint);
  }

  _drawHorizontalLine(Canvas canvas, Size size, double y, Paint paint) {
    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }

  _drawHorizontalDashPath(Canvas canvas, Size size, double y, Paint paint) {
    var path = Path();
    path.moveTo(0, y);

    path.lineTo(size.width, y);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[3, 3]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
