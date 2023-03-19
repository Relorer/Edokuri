// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_button.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_switch.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  SettingsPageState createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController controller = TextEditingController();
  final OnDeviceTranslatorModelManager manager =
      OnDeviceTranslatorModelManager();
  final ToastController toastController = ToastController();

  void checkStateDownloadModel() async {
    if (!getIt<MLController>().isLoaded) {
      await getIt<MLController>().downloadModels();
      toastController.showDefaultTost("Language model is downloaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PhantomAppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: BouncingCustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).secondBackgroundColor,
            title: const Text("Settings"),
            floating: true,
          ),
          SliverSingleChild(Column(
            children: [
              getIt<MLController>().isLoaded
                  ? const SettingPageButton(
                      text: "Language model is loaded",
                      svg: translateSvg,
                    )
                  : SettingPageButton(
                      text: "Load the language model",
                      onTap: checkStateDownloadModel,
                      svg: translateSvg,
                    ),
              Observer(builder: (context) {
                final settings = getIt<SettingsController>();
                return SettingsPageSwitch(
                  svg: einkSvg,
                  text: "Eink mode",
                  value: settings.einkMode,
                  onChanged: settings.setEinkMode,
                );
              }),
              SettingPageButton(
                text: "Sign out",
                onTap: () async {
                  await getIt<PocketbaseController>().logout();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                svg: exitSvg,
              ),
            ],
          ))
        ],
      )),
    );
  }
}
