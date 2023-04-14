// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/models/time_intervals_consts.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/base_word.dart';

class FormWord extends StatelessWidget {
  final Piece word;
  final int reviewInterval;
  final GestureTapCallback? onTap;
  const FormWord(
      {super.key,
      required this.word,
      required this.reviewInterval,
      this.onTap});

  double getOpacity() {
    int yearDifference = oneYear - min(reviewInterval, oneYear);
    double dividedDifference = yearDifference / oneYear;
    double opacity = 0.4 * dividedDifference;
    return opacity;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWord(
      color: const Color(0xFFF07D00).withOpacity(getOpacity() * 0.5),
      word: word,
      onTap: onTap,
    );
  }
}
