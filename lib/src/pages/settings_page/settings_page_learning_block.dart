// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';

// 📦 Package imports:

class SettingsPageLearningBlock extends StatelessWidget {
  const SettingsPageLearningBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(SettingsPageBlockContainer(
      child: Column(
        children: const [],
      ),
    ));
  }
}
