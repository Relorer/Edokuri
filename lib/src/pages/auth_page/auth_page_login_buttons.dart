import 'package:flutter/material.dart';
import 'package:freader/src/pages/auth_page/auth_page_button.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme_consts.dart';

class AuthPageLoginButtons extends StatelessWidget {
  const AuthPageLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const AuthPageButton(svg: googleLogoSvg, text: "Sign in with Google"),
        const SizedBox(
          height: doubleDefaultMargin,
        ),
        const AuthPageButton(
          svg: githubMarkWhiteSvg,
          text: "Sign in with GitHub",
          bg: Color(0xFF444444),
          textColor: Colors.white,
        ),
        const SizedBox(
          height: doubleDefaultMargin,
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

//  TextButton(
//                 onPressed: () {
//                   var a = getIt<Appwrite>();
//                   final account = Account(a.client);
//                   account.createOAuth2Session(provider: 'google');
//                 },
//                 child: Text("test"))