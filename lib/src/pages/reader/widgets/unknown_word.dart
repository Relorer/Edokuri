import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/reader/widgets/base_word.dart';
import 'package:freader/src/theme/theme.dart';

class UnknownWord extends StatelessWidget {
  final Piece word;
  final GestureTapCallback? onTap;
  const UnknownWord({super.key, required this.word, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseWord(
      color: Theme.of(context).unknownWordColor.withOpacity(0.4),
      word: word,
      onTap: onTap,
    );
  }
}
