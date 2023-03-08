// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class DefaultBottomSheet extends StatelessWidget {
  final List<Widget> children;

  const DefaultBottomSheet({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(defaultRadius),
        topRight: Radius.circular(defaultRadius),
      ),
      child: Container(
        color: Theme.of(context).secondBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...children,
            const SizedBox(
              height: 55,
            )
          ],
        ),
      ),
    );
  }
}
