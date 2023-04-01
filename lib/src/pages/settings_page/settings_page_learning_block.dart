// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_button.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageLearningBlock extends StatelessWidget {
  const SettingsPageLearningBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(Material(
      color: Colors.transparent,
      child: SettingsPageBlockContainer(
        child: Observer(builder: (context) {
          return Column(
            children: [
              const SizedBox(
                height: defaultRadius,
              ),
              SettingPageButton(
                text: "Clear known words",
                onTap: () async {
                  await getIt<KnownRecordsRepository>().removeAll();
                  getIt<ToastController>()
                      .showDefaultTost("Known words cleared");
                },
                svg: trashSvg,
              ),
              const SizedBox(
                height: defaultRadius,
              ),
            ],
          );
        }),
      ),
    ));
  }
}
