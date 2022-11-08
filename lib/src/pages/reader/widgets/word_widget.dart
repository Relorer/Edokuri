import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';

class WordWidget extends StatelessWidget {
  final Piece word;
  final GestureTapCallback? onTap;

  const WordWidget({Key? key, required this.word, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffFBE1B2),
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
