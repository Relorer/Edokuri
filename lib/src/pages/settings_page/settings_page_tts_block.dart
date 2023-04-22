// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_button.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_drop_list.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_slider.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageTTSBlock extends StatefulWidget {
  const SettingsPageTTSBlock({super.key});

  @override
  State<SettingsPageTTSBlock> createState() => _SettingsPageTTSBlockState();
}

class _SettingsPageTTSBlockState extends State<SettingsPageTTSBlock> {
  final voiceNames = getIt<TTSController>().voices.map((e) {
    final fullName = e["name"].toString().toLowerCase();
    final name = fullName
        .replaceFirst("en-us-", "")
        .replaceFirst("x-", "")
        .replaceAll("-", " ");
    return SettingsPageDropListValue(e["name"].toString(), name);
  }).toList();

  String selectedVoice = getIt<SettingsController>().voice;

  @override
  Widget build(BuildContext context) {
    if (selectedVoice.isEmpty) {
      selectedVoice = voiceNames.first.value;
      getIt<SettingsController>().setVoice(selectedVoice);
    }
    voiceNames.sort((a, b) => a.text.compareTo(b.text));

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
              SettingsPageDropList(
                  svg: speakerSvg,
                  text: "Voice",
                  value: selectedVoice,
                  values: voiceNames,
                  onChanged: (value) {
                    setState(() {
                      selectedVoice = value;
                    });
                    getIt<SettingsController>().setVoice(value);
                  }),
              SettingsPageSlider(
                text: "Max rate",
                min: 0.1,
                value: settings.ttsMaxRate,
                onChanged: settings.setTtsMaxRate,
              ),
              SettingsPageSlider(
                text: "Min rate ",
                min: 0.1,
                value: settings.ttsMinRate,
                onChanged: settings.setTtsMinRate,
              ),
              SettingPageButton(
                text: "Test TTS",
                onTap: () {
                  getIt<TTSController>()
                      .speak("The quick brown fox jumps over the lazy dog.");
                },
                svg: bookMusicSvg,
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
