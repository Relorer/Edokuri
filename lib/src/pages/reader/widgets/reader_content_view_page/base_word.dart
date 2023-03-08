// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class BaseWord extends StatelessWidget {
  final Color color;
  final Piece word;
  final GestureTapCallback? onTap;

  const BaseWord(
      {Key? key, required this.word, this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(defaultRadius / 2),
        ),
        child: Text(
          word.content,
          style: TextStyle(
              fontSize: Theme.of(context).readerPageTextStyle.fontSize,
              color: Theme.of(context).readerPageTextStyle.color),
        ),
      ),
    );
  }
}
