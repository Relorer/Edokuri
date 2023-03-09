import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/common/translator_controller/translator_controller_factory.dart';
import 'package:freader/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../../core/service_locator.dart';

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
          SliverSingleChild(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Observer(
                builder: (_) => Column(
                  children: [
                    TextButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black38, // foreground
                        ),
                        onPressed: () => {
                              if (getIt<MLController>().isLoaded)
                                {
                                  manager.deleteModel(
                                      TranslateLanguage.english.bcpCode),
                                  manager.deleteModel(
                                      TranslateLanguage.russian.bcpCode)
                                }
                              else
                                {
                                  manager.downloadModel(
                                      TranslateLanguage.english.bcpCode),
                                  manager.downloadModel(
                                      TranslateLanguage.russian.bcpCode)
                                }
                            },
                        child: Text(getIt<MLController>().isLoaded
                            ? "Delete"
                            : "Download"))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
