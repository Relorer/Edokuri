// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';

class AuthPageLogo extends StatelessWidget {
  const AuthPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image(
      gaplessPlayback: true,
      image: getIt<SettingsController>().einkMode
          ? const AssetImage("assets/images/logo-dark.png")
          : const AssetImage("assets/images/logo.png"),
      height: 280,
    ));
  }
}
