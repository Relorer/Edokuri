// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:path_drawing/path_drawing.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

final Map<int, String> weekdayName = {
  1: "MO",
  2: "TU",
  3: "WE",
  4: "TH",
  5: "FR",
  6: "SA",
  7: "SU"
};

class StatsGraphPainter extends CustomPainter {
  final BuildContext context;
  final GraphData graphData;
  final Offset? pressedPosition;
  final List<double> placeholder;

  late Iterable<int> recordsByDays;
  late double avg;
  late int maxValue;
  late double columnNameHeight;

  final radius = const Radius.circular(defaultRadius);

  late TextStyle graphWeekdayStyle;

  StatsGraphPainter(
      {required this.context,
      required this.graphData,
      required this.placeholder,
      required this.pressedPosition}) {
    recordsByDays = graphData.days.map((e) => e.total);
    avg = recordsByDays.isNotEmpty
        ? recordsByDays.reduce((a, b) => a + b) / graphData.days.length
        : 0;
    maxValue = recordsByDays.isNotEmpty ? recordsByDays.reduce(max) : 0;

    graphWeekdayStyle = Theme.of(context).graphWeekdayStyle;

    columnNameHeight =
        _getTextPainterGraphWeekday(weekdayName[1]!, graphWeekdayStyle)
                .size
                .height +
            defaultMargin;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final graphHeight = size.height - columnNameHeight;

    const edge = defaultMargin;
    final columnCount = graphData.days.length;
    final offsetCount = columnCount - 1;
    const columnOffsetRatio = .7;

    final columnWidth = (size.width - edge * 2) /
        (columnCount + offsetCount * columnOffsetRatio);
    final offsetBetween =
        (size.width - columnCount * columnWidth - edge * 2) / offsetCount;

    bool columnSelected = false;

    if (pressedPosition != null) {
      for (var i = 0; i < columnCount; i++) {
        final x1 = i * columnWidth + offsetBetween * i + edge;
        final x2 = x1 + columnWidth;
        if (pressedPosition!.dx <= x2 + offsetBetween / 2 &&
            pressedPosition!.dx >= x1 - offsetBetween / 2 &&
            graphData.days[i].total > 0) {
          columnSelected = true;
        }
      }
    }

    for (var i = 0; i < columnCount; i++) {
      final x1 = i * columnWidth + offsetBetween * i + edge;
      final x2 = x1 + columnWidth;

      final columnNameStyle = i == columnCount - 1
          ? graphWeekdayStyle.copyWith(color: Colors.white)
          : graphWeekdayStyle;
      _drawColumnName(canvas, weekdayName[graphData.days[i].date.weekday]!,
          x1 + columnWidth / 2, size.height, columnNameStyle);

      if (columnSelected &&
          !(pressedPosition!.dx <= x2 + offsetBetween / 2 &&
              pressedPosition!.dx >= x1 - offsetBetween / 2)) {
        continue;
      }

      _drawColumn(canvas, x1, defaultMargin * (columnSelected ? 2 : 1), x2,
          graphHeight - defaultMargin, graphData.days[i], placeholder[i]);

      if (columnSelected &&
          pressedPosition!.dx <= x2 + offsetBetween / 2 &&
          pressedPosition!.dx >= x1 - offsetBetween / 2) {
        var text = _getTextPainterGraphWeekday(
            graphData.days[i].total.toString(),
            graphWeekdayStyle.copyWith(
                fontSize: 10, fontWeight: FontWeight.bold));

        final textOffset = Offset(x1 + columnWidth / 2 - text.size.width / 2,
            defaultMargin - text.size.height / 2);
        text.paint(canvas, textOffset);
      }
    }

    _drawGrid(canvas, Size(size.width, size.height - columnNameHeight));
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
      final columnTop = bottom - placeholder * height;
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            left,
            columnTop,
            right,
            bottom,
          ),
          paint..color = Theme.of(context).lightGrayColor);

      _roundColumns(canvas, left, columnTop, right, bottom);
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
          paint..color = orange);

      //newSavedWords
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            left,
            newSavedWordsY1,
            right,
            newSavedWordsY2,
          ),
          paint..color = darkOrange);

      _roundColumns(canvas, left, newKnownWordsY1, right, bottom);
    }
  }

  _roundColumns(
      Canvas canvas, double left, double top, double right, double bottom) {
    final roundingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = defaultRadius
      ..color = darkGray;

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
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = lightGray.withOpacity(0.15);

    _drawHorizontalLine(canvas, size, 0, paint);

    final height = size.height - doubleDefaultMargin;
    _drawHorizontalDashPath(
        canvas, size, height - avg / maxValue * height + defaultMargin, paint);
    _drawHorizontalLine(canvas, size, size.height, paint);
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
