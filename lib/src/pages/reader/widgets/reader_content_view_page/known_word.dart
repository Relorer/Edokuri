import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view_page/base_word.dart';

class KnownWord extends StatelessWidget {
  final Piece word;
  final GestureTapCallback? onTap;
  const KnownWord({super.key, required this.word, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseWord(
      color: Colors.transparent,
      word: word,
      onTap: onTap,
    );
  }
}
