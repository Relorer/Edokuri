// 🐦 Flutter imports:
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/common/translator_controller/services/yandex_translator_service.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
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
            key: YandexTranslatorServiceKey, value: controller.text);
      });
    });
    getYaKey();
    super.initState();
  }

  void getYaKey() async {
    final yaKey = await secureStorage.read(key: YandexTranslatorServiceKey);
    controller.text = yaKey ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(Material(
      color: Colors.transparent,
      child: SettingsPageBlockContainer(
        child: Observer(builder: (context) {
          final settings = getIt<SettingsController>();

          return Column(
            children: [
              const SizedBox(
                height: defaultRadius,
              ),
              SettingsPageSwitch(
                svg: yaTranslateSvg,
                colorFilter: false,
                text: "Yandex Translation API",
                value: settings.useYaTranslator,
                onChanged: settings.setUseYaTranslator,
              ),
              settings.useYaTranslator
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
                  final rr = getIt<RecordRepository>();
                  for (var record in rr.records) {
                    rr.updateTranslate(record);
                  }
                  getIt<ToastController>().showDefaultTost("Re-Translate done");
                },
                svg: loopSvg,
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
