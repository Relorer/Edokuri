import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/models/graph.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'dart:math';

import 'package:path_drawing/path_drawing.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = new Random();

    GraphData data = GraphData([0, 1, 2, 3, 4, 5, 6]
        .reversed
        .map((e) => GraphDayData(random.nextInt(100), random.nextInt(100),
            random.nextInt(100), DateTime.now().subtract(Duration(days: e))))
        .toList());

    return CustomPaint(painter: Graph(data));
  }
}

class Graph extends CustomPainter {
  final Map<int, String> weekdayName = {
    1: "MO",
    2: "TU",
    3: "WE",
    4: "TH",
    5: "FR",
    6: "SA",
    7: "SU"
  };

  final GraphData data;

  late Iterable<int> recordsByDays;
  late double avg;
  late int maxValue;

  Graph(this.data) {
    recordsByDays = data.days
        .map((e) => e.newKnownWords + e.newSavedWords + e.reviewedWords);
    avg = recordsByDays.reduce((a, b) => a + b) / data.days.length;
    maxValue = recordsByDays.reduce(max);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height),
        Paint()..color = Colors.transparent);

    const textStyle = TextStyle(
      color: paleElement,
      fontSize: 12,
    );
    final textSpan = TextSpan(
      text: weekdayName[0],
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final columnNameHeight = textPainter.size.height + defaultMargin;

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
          graphHeight - defaultMargin, data.days[i]);

      final textSpan = TextSpan(
        text: weekdayName[data.days[i].date.weekday],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final offset = Offset(x1 + columnWidth / 2 - textPainter.size.width / 2,
          size.height - textPainter.size.height);

      textPainter.paint(canvas, offset);
    }

    _drawGrid(canvas, Size(size.width, size.height - columnNameHeight));
  }

  _drawColumn(Canvas canvas, double left, double top, double right,
      double bottom, GraphDayData data) {
    final paint = Paint();

    final height = bottom - top;

    final newSavedWordsY1 = bottom - data.newSavedWords / maxValue * height;
    final newSavedWordsY2 = bottom;

    final reviewedWordsY1 =
        newSavedWordsY1 - data.reviewedWords / maxValue * height;
    final reviewedWordsY2 = newSavedWordsY1;

    final newKnownWordsY1 =
        reviewedWordsY1 - data.newKnownWords / maxValue * height;
    final newKnownWordsY2 = reviewedWordsY1;

    //newKnownWords
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          left,
          newKnownWordsY1,
          right,
          newKnownWordsY2,
        ),
        paint..color = white);

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

    //rounding
    final roundingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = defaultRadius
      ..color = darkGray;

    const radius = Radius.circular(defaultRadius);

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
            left - defaultRadius / 2,
            newKnownWordsY1 - defaultRadius / 2,
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
