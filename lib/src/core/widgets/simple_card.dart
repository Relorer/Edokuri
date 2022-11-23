import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

class SimpleCard extends StatelessWidget {
  final Widget? child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const SimpleCard({super.key, this.child, this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(0),
      child: InkWell(
        highlightColor: Theme.of(context).secondBackgroundColor.withAlpha(40),
        splashColor: Theme.of(context).secondBackgroundColor.withAlpha(30),
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
