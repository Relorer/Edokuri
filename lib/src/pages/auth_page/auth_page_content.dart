// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/circular_progress_indicator_pale.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/auth_page/auth_page_blur_text_bg.dart';
import 'package:edokuri/src/pages/auth_page/auth_page_login_buttons.dart';
import 'package:edokuri/src/pages/auth_page/auth_page_logo.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class AuthPageContent extends StatelessWidget {
  const AuthPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: Theme.of(context).secondBackgroundColor,
      child: Stack(
        children: [
          getIt<SettingsController>().einkMode
              ? const SizedBox()
              : const AuthPageBlurTextBg(),
          Observer(builder: (context) {
            final pocketbase = getIt<PocketbaseController>();

            if (pocketbase.isLoading) {
              return const CircularProgressIndicatorPale();
            }
            return BouncingCustomScrollView(
              revers: true,
              slivers: [
                SliverSingleChild(Column(
                  children: const [
                    AuthPageLogo(),
                    Padding(
                        padding: EdgeInsets.all(doubleDefaultMargin * 2),
                        child: AuthPageLoginButtons())
                  ],
                ))
              ],
            );
          })
        ],
      ),
    );
  }
}
