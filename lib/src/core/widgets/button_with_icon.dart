// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final String svg;
  final GestureTapCallback? onTap;
  final Color? color;
  final TextStyle? style;
  final Color? highlightColor;

  const ButtonWithIcon(
      {Key? key,
      required this.svg,
      this.onTap,
      required this.text,
      this.color,
      this.highlightColor,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Theme.of(context).secondBackgroundColor,
      child: InkWell(
        highlightColor: (highlightColor ?? Colors.white).withAlpha(40),
        splashColor: (highlightColor ?? Colors.white).withAlpha(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(doubleDefaultMargin),
          child: Row(children: [
            SizedBox(
              width: 24,
              child: Center(
                child: SvgPicture.asset(
                  svg,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).paleElementColor, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(
              width: doubleDefaultMargin,
            ),
            Text(
              text,
              style: style ?? Theme.of(context).dialogTextStyleBright,
            )
          ]),
        ),
      ),
    );
  }
}
