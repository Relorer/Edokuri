// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/ellipsis_text.dart';
import 'package:edokuri/src/core/widgets/simple_card.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class AuthPageButton extends StatelessWidget {
  final String svg;
  final String text;
  final Color bg;
  final Color textColor;
  final void Function()? onTap;

  const AuthPageButton(
      {super.key,
      required this.svg,
      required this.text,
      this.onTap,
      this.bg = Colors.white,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      color: bg,
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: defaultMargin),
          child: Row(
            children: [
              Center(
                child: SvgPicture.asset(svg, height: 30),
              ),
              const SizedBox(
                width: doubleDefaultMargin,
              ),
              Expanded(
                child: EllipsisText(
                  text,
                  style: Theme.of(context)
                      .bookTitleStyle
                      .copyWith(color: textColor),
                ),
              ),
            ],
          )),
    );
  }
}
