// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/base_word.dart';
import 'package:edokuri/src/theme/theme.dart';

class SavedWord extends StatelessWidget {
  final Piece word;
  final double interval;
  final GestureTapCallback? onTap;
  const SavedWord(
      {super.key, required this.word, required this.interval, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseWord(
      color: Theme.of(context)
          .savedWordColor
          .withOpacity(0.4 * ((7 - min(interval, 7)) / 7)), // TODO разобраться с цветами
      word: word,
      onTap: onTap,
    );
  }
}
