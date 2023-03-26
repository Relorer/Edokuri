// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';

class SettingsPageProfile extends StatelessWidget {
  const SettingsPageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final pocketbase = getIt<PocketbaseController>();

    return SliverSingleChild(SettingsPageBlockContainer(
      child: Column(children: [
        Text(pocketbase.user?.name ?? "Unknown"),
        const SizedBox(height: 100),
      ]),
    ));
  }
}
