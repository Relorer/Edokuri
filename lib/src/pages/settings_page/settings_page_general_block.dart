// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/controllers/stores/package_controller/package_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_button.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_drop_list.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_switch.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageGeneralBlock extends StatefulWidget {
  const SettingsPageGeneralBlock({super.key});

  @override
  State<SettingsPageGeneralBlock> createState() =>
      _SettingsPageGeneralBlockState();
}

class _SettingsPageGeneralBlockState extends State<SettingsPageGeneralBlock> {
  final secureStorage = getIt<FlutterSecureStorage>();
  TextEditingController controller = TextEditingController();

  void checkStateDownloadModel() async {
    if (!getIt<MLController>().isLoaded) {
      await getIt<MLController>().downloadModels();
      getIt<ToastController>().showDefaultTost("Language model is downloaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(Material(
      color: Colors.transparent,
      child: SettingsPageBlockContainer(
        child: Observer(builder: (context) {
          final settings = getIt<SettingsController>();
          final package = getIt<PackageController>();
          return Column(
            children: [
              const SizedBox(
                height: defaultRadius,
              ),
              getIt<MLController>().isLoaded
                  ? const SizedBox()
                  : SettingPageButton(
                      text: "Load the language model",
                      onTap: checkStateDownloadModel,
                      svg: translateSvg,
                    ),
              SettingsPageDropList(
                svg: languageSvg,
                text: "Language",
                value: "English",
                values: const ["English"],
                onChanged: (value) {},
              ),
              SettingsPageSwitch(
                svg: einkSvg,
                text: "Eink mode",
                value: settings.einkMode,
                onChanged: settings.setEinkMode,
              ),
              SettingsPageSwitch(
                svg: fitScreenSvg,
                text: "Safe area",
                value: settings.safeArea,
                onChanged: settings.setSafeArea,
              ),
              package.thereIsNewVersion
                  ? SettingPageButton(
                      color: const Color(0xFFF8EACD),
                      text: "Update to ${package.latestVersion?.version}",
                      onTap: package.update,
                      svg: updateSvg,
                    )
                  : const SizedBox(),
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
