import 'package:flutter/material.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/base_word.dart';
import 'package:edokuri/src/theme/theme.dart';

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
