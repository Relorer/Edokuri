// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/alert_dialog.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/safe_area_with_settings.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header_text.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header_text_with_tip.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_general_block.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_learning_block.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_package_info.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_profile.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_translation_block.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_tts_block.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

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
    return Container(
      color: Theme.of(context).secondBackgroundColor,
      child: Observer(builder: (context) {
        final settings = getIt<SettingsController>();
        settings.safeArea;
        return SafeAreaWithSettings(
          child: Scaffold(
            appBar: const PhantomAppBar(),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: BouncingCustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).secondBackgroundColor,
                  title: const Text("Settings"),
                  floating: true,
                  actions: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        exitSvg,
                        colorFilter:
                            const ColorFilter.mode(lightGray, BlendMode.srcIn),
                      ),
                      onPressed: () async {
                        final pocketbase = getIt<PocketbaseController>();
                        final result = pocketbase.user?.email == null ||
                                pocketbase.user?.email == ""
                            ? await showOkCancelAlertDialogStyled(
                                context: context,
                                title: "Leave profile?",
                                message:
                                    "You will be able to transfer your data to a new account when you log in to this device next time",
                                okLabel: "Yes",
                              )
                            : await showOkCancelAlertDialogStyled(
                                context: context,
                                title: "Leave profile?",
                                okLabel: "Yes",
                              );

                        if (result == OkCancelResult.ok) {
                          await getIt<PocketbaseController>().logout();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ],
                ),
                const SettingsPageProfile(),
                const SectionHeaderText(
                  leftText: "General",
                ),
                const SettingsPageGeneralBlock(),
                const SectionHeaderTextWithTip(
                  leftText: "Translation",
                  tip:
                      'You can change the priority and disable unwanted translators',
                ),
                const SettingsPageTranslationBlock(),
                const SectionHeaderText(
                  leftText: "TTS",
                ),
                const SettingsPageTTSBlock(),
                const SectionHeaderText(
                  leftText: "Learning",
                ),
                const SettingsPageLearningBlock(),
                const SettingsPagePackageInfo()
              ],
            ),
          ),
        );
      }),
    );
  }
}
