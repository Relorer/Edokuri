// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class DefaultCardContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  const DefaultCardContainer(this.child, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultRadius)),
            boxShadow: [
              BoxShadow(
                blurRadius: defaultMargin,
                color: Theme.of(context).lightGrayColor.withOpacity(0.4),
                spreadRadius: 0.0,
                offset: const Offset(0, 5),
              ),
            ]),
        child: child);
  }
}
