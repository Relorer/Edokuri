// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class PersonAppBarLine extends StatelessWidget {
  final String title;
  final String value;

  const PersonAppBarLine(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: doubleDefaultMargin, vertical: defaultMargin),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Theme.of(context).lightGrayColor),
          ),
          const SizedBox(width: defaultMargin),
          Text(
            value.toUpperCase(),
            style: Theme.of(context).textTheme.displayLarge,
          )
        ],
      ),
    );
  }
}
