import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final String svg;
  final GestureTapCallback? onTap;

  const ButtonWithIcon(
      {Key? key, required this.svg, this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).secondBackgroundColor,
      child: InkWell(
        highlightColor: Colors.white.withAlpha(40),
        splashColor: Colors.white.withAlpha(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(doubleDefaultMargin),
          child: Row(children: [
            SvgPicture.asset(
              svg,
              color: Theme.of(context).paleElementColor,
            ),
            const SizedBox(
              width: doubleDefaultMargin,
            ),
            Text(
              text,
              style: Theme.of(context).dialogTextStyleBright,
            )
          ]),
        ),
      ),
    );
  }
}
