// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';

class SimpleCard extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const SimpleCard(
      {super.key, this.child, this.onLongPress, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(0),
      child: Opacity(
        opacity: onTap == null ? 0.66 : 1,
        child: InkWell(
          highlightColor: Theme.of(context).secondBackgroundColor.withAlpha(40),
          splashColor: Theme.of(context).secondBackgroundColor.withAlpha(30),
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}
