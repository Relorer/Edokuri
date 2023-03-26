// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header_text.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_general_block.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_learning_block.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_profile.dart';
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
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                  exitSvg,
                  colorFilter:
                      const ColorFilter.mode(paleElement, BlendMode.srcIn),
                ),
                onPressed: () async {
                  await getIt<PocketbaseController>().logout();
                  if (context.mounted) {
                    Navigator.pop(context);
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
          const SectionHeaderText(
            leftText: "Learning",
          ),
          const SettingsPageLearningBlock(),
        ],
      )),
    );
  }
}
