// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator/yandex_translator_service.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/alert_dialog.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_button.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_switch.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_text_form.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageTranslationBlock extends StatefulWidget {
  const SettingsPageTranslationBlock({super.key});

  @override
  State<SettingsPageTranslationBlock> createState() =>
      _SettingsPageTranslationBlockState();
}

class _SettingsPageTranslationBlockState
    extends State<SettingsPageTranslationBlock> {
  final secureStorage = getIt<FlutterSecureStorage>();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.addListener(() {
      EasyDebounce.debounce('change-ya-key', const Duration(seconds: 1), () {
        secureStorage.write(
            key: yandexTranslatorServiceKey, value: controller.text);
      });
    });
    getYaKey();
    super.initState();
  }

  void getYaKey() async {
    final yaKey = await secureStorage.read(key: yandexTranslatorServiceKey);
    controller.text = yaKey ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final settings = getIt<SettingsController>();
      settings.translatorOrderIndexes;
      var switchWidgets = [
        SettingsPageSwitch(
          key: const ValueKey("useDeeplTranslator"),
          svg: deeplSvg,
          colorFilter: false,
          text: "DeepL",
          value: settings.useDeeplTranslator,
          onChanged: settings.setUseDeeplTranslator,
        ),
        SettingsPageSwitch(
          key: const ValueKey("useYandexTranslator"),
          svg: yaTranslateSvg,
          colorFilter: false,
          text: "Yandex",
          value: settings.useYandexTranslator,
          onChanged: settings.setUseYaTranslator,
        ),
        SettingsPageSwitch(
          key: const ValueKey("useGoogleTranslator"),
          svg: googleSvg,
          colorFilter: false,
          text: "Google",
          value: settings.useGoogleTranslator,
          onChanged: settings.setUseGoogleTranslator,
        ),
        const SettingsPageSwitch(
          key: ValueKey("useGoogleMLTranslator"),
          svg: googleTranslationSvg,
          colorFilter: false,
          text: "Google ML",
          value: true,
        ),
      ];

      switchWidgets =
          settings.translatorOrderIndexes.map((e) => switchWidgets[e]).toList();

      return SliverSingleChild(Material(
        color: Colors.transparent,
        child: SettingsPageBlockContainer(
          child: Column(
            children: [
              const SizedBox(
                height: defaultRadius,
              ),
              SizedBox(
                height: 240,
                child: ReorderableListView(
                  physics: const BouncingScrollPhysics(),
                  children: switchWidgets,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final current = settings.translatorOrderIndexes;
                    final temp = current[oldIndex];
                    current.removeAt(oldIndex);
                    current.insert(newIndex, temp);
                    settings.setTranslatorOrderIndexes(current);
                    setState(() {});
                  },
                ),
              ),
              settings.useYandexTranslator
                  ? SettingsPageTextForm(
                      controller: controller,
                      svg: keySvg,
                      hint: "",
                      labelText: "Ya Api key",
                    )
                  : const SizedBox(),
              SettingPageButton(
                text: "Re-Translate sentence",
                onTap: () async {
                  final result = await showOkCancelAlertDialogStyled(
                    context: context,
                    title:
                        "Are you sure you want to re-translate your entire dictionary?",
                    okLabel: "Yes",
                  );
                  if (result == OkCancelResult.ok) {
                    final rr = getIt<RecordRepository>();
                    await rr.updateTranslationWithSaveAll();
                    getIt<ToastController>()
                        .showDefaultTost("Re-Translate done");
                  }
                },
                svg: loopSvg,
              ),
              const SizedBox(
                height: defaultRadius,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
