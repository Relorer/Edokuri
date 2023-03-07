import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/pages/auth_page/auth_page_button.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme_consts.dart';

class AuthPageLoginButtons extends StatelessWidget {
  const AuthPageLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var pocketbase = getIt<PocketbaseController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AuthPageButton(
          svg: googleLogoSvg,
          text: "Sign in with Google",
          onTap: pocketbase.googleAuth,
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
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
