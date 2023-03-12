// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class AuthPageBlurTextBg extends StatelessWidget {
  const AuthPageBlurTextBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Blur(
        blur: 2.5,
        colorOpacity: 0.985,
        blurColor: Theme.of(context).secondBackgroundColor,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: defaultMargin),
          child: AutoSizeText(
            "Unlock the power of language with Edokuri - the innovative foreign book reader designed to boost your vocabulary and enhance your reading experience! With its cutting-edge memory aids, you'll never forget a word or phrase again. Immerse yourself in new worlds and broaden your horizons with Edokuri by your side.",
            style: TextStyle(
                fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
