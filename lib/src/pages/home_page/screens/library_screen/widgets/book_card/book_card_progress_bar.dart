import 'package:flutter/material.dart';
import 'package:edokuri/src/theme/theme.dart';

class BookCardProgressBar extends StatelessWidget {
  final int current;
  final int max;

  const BookCardProgressBar(
      {super.key, required this.current, required this.max});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 4,
        child: LinearProgressIndicator(
          value: current / max,
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).progressBarActiveColor),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
