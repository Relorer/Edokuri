import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class DefaultCardContainer extends StatelessWidget {
  final Widget? child;
  const DefaultCardContainer(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultRadius)),
            boxShadow: [
              BoxShadow(
                blurRadius: defaultMargin,
                color: Theme.of(context).paleElementColor.withOpacity(0.4),
                spreadRadius: 0.0,
                offset: const Offset(0, 5),
              ),
            ]),
        child: child);
  }
}
