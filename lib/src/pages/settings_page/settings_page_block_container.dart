// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageBlockContainer extends StatelessWidget {
  final Widget child;

  const SettingsPageBlockContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
      ),
      child: child,
    );
  }
}
