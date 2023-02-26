import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/pages/auth_page/auth_page_button.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme_consts.dart';

class AuthPageLoginButtons extends StatelessWidget {
  const AuthPageLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var appwrite = getIt<AppwriteController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AuthPageButton(
          svg: googleLogoSvg,
          text: "Sign in with Google",
          onTap: appwrite.googleAuth,
        ),
        const SizedBox(
          height: doubleDefaultMargin,
        ),
        AuthPageButton(
          svg: githubMarkWhiteSvg,
          text: "Sign in with GitHub",
          bg: const Color(0xFF444444),
          textColor: Colors.white,
          onTap: appwrite.githubAuth,
        ),
        const SizedBox(
          height: doubleDefaultMargin,
        ),
        TextButton(
          onPressed: appwrite.skipAuth,
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
