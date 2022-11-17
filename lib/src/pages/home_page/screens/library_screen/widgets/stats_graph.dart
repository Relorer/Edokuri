import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/graph.dart';
import 'package:freader/src/theme/theme.dart';
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
  final GraphData data;

  final double columnNameHeight = doubleDefaultMargin;
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

      _drawColumn(canvas, x1, edge, x2, graphHeight, data.days[i]);
    }

    _drawGrid(canvas, size);
    // const textStyle = TextStyle(
    //   color: Colors.black,
    //   fontSize: 30,
    // );
    // const textSpan = TextSpan(
    //   text: 'FR',
    //   style: textStyle,
    // );
    // final textPainter = TextPainter(
    //   text: textSpan,
    //   textDirection: TextDirection.ltr,
    // );
    // textPainter.layout(
    //   minWidth: 0,
    //   maxWidth: size.width,
    // );
    // final xCenter = (size.width - textPainter.width) / 2;
    // final yCenter = (size.height - textPainter.height) / 2;
    // final offset = Offset(xCenter, yCenter);
    // textPainter.paint(canvas, offset);
  }

  _drawColumn(Canvas canvas, double left, double top, double right,
      double bottom, GraphDayData data) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber;

    const radius = Radius.circular(defaultRadius);

    final maxInThisDay = [
      data.newKnownWords,
      data.newSavedWords,
      data.reviewedWords
    ].reduce(max);

    final height = bottom - top;

    //newKnownWords
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
            left,
            ((height - data.newSavedWords / maxValue * height) -
                    data.reviewedWords / maxValue * height) -
                data.newKnownWords / maxValue * height,
            right,
            (height - data.newSavedWords / maxValue * height) -
                data.reviewedWords / maxValue * height,
            topRight: radius),
        paint..color = white);

    //reviewedWords
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          left,
          (height - data.newSavedWords / maxValue * height) -
              data.reviewedWords / maxValue * height,
          right,
          height - data.newSavedWords / maxValue * height,
        ),
        paint..color = unknownWord);

    //newSavedWords
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          left,
          height - data.newSavedWords / maxValue * height,
          right,
          bottom,
        ),
        paint..color = savedWord);

    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = defaultRadius * 2
      ..color = Colors.amber;

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
            left - defaultRadius,
            height - data.newSavedWords / maxValue * height - defaultRadius,
            right + defaultRadius,
            bottom + defaultRadius,
            bottomLeft: Radius.circular(defaultRadius * 2),
            bottomRight: Radius.circular(defaultRadius * 2)),
        paint2..color = darkGray);
  }

  _drawGrid(Canvas canvas, Size size) {
    final height = size.height - columnNameHeight;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = paleElement.withOpacity(0.3);

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
