// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';

class SafeAreaWithSettings extends StatelessWidget {
  final Widget child;
  const SafeAreaWithSettings({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final settings = getIt<SettingsController>();
    return SafeArea(
      top: false,
      bottom: settings.safeArea,
      left: settings.safeArea,
      right: settings.safeArea,
      child: child,
    );
  }
}
