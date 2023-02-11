import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view_page/base_word.dart';
import 'package:freader/src/theme/theme.dart';

class SavedWord extends StatelessWidget {
  final Piece word;
  final int reviewNumber;
  final GestureTapCallback? onTap;
  const SavedWord(
      {super.key, required this.word, required this.reviewNumber, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseWord(
      color: Theme.of(context)
          .savedWordColor
          .withOpacity(0.4 * ((7 - min(reviewNumber, 7)) / 7)),
      word: word,
      onTap: onTap,
    );
  }
}
