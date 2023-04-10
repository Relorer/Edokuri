// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/package_controller/package_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPagePackageInfo extends StatelessWidget {
  const SettingsPagePackageInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final PackageController packageController = getIt<PackageController>();
    return SliverSingleChild(Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: doubleDefaultMargin, horizontal: defaultMargin),
          child: Text(
            "Edokuri for Android v${packageController.version} (${packageController.buildNumber})",
            style: const TextStyle(fontSize: 14, color: lightGray),
          ),
        ),
      ],
    ));
  }
}
