// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/pages/auth_page/auth_page_button.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class AuthPageLoginButtons extends StatelessWidget {
  const AuthPageLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var pocketbase = getIt<PocketbaseController>();
    final settings = getIt<SettingsController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AuthPageButton(
          svg: googleLogoSvg,
          text: "Sign in with Google",
          bg: settings.einkMode ? lightGray : white,
          onTap: pocketbase.googleAuth,
          textColor: settings.einkMode ? Colors.white : Colors.black,
        ),
        const SizedBox(
          height: doubleDefaultMargin,
        ),
        AuthPageButton(
          svg: githubMarkWhiteSvg,
          text: "Sign in with GitHub",
          bg: const Color(0xFF444444),
          textColor: Colors.white,
          onTap: pocketbase.githubAuth,
        ),
        const SizedBox(
          height: doubleDefaultMargin,
        ),
        TextButton(
          onPressed: pocketbase.skipAuth,
          child: Text(
            "Skip",
            style: TextStyle(
                color: settings.einkMode ? Colors.black : Colors.white),
          ),
        )
      ],
    );
  }
}
