import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String leftText;
  final String rightText;

  const TitleWidget({Key? key, required this.leftText, required this.rightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText.toUpperCase(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          rightText.toUpperCase(),
          style: Theme.of(context).textTheme.displayLarge,
        )
      ],
    );
  }
}
