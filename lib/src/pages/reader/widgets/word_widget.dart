import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/theme/theme_consts.dart';

class WordWidget extends StatelessWidget {
  final Piece word;
  final GestureTapCallback? onTap;

  const WordWidget({Key? key, required this.word, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: progressBarActive.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          word.content,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
