// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/theme/theme.dart';

class SettingPageButton extends StatelessWidget {
  final String text;
  final String svg;
  final GestureTapCallback? onTap;

  const SettingPageButton({
    Key? key,
    required this.svg,
    this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWithIcon(
      color: Colors.transparent,
      highlightColor: Theme.of(context).secondBackgroundColor,
      style: Theme.of(context).dialogTextStyleBright.copyWith(
          color: Theme.of(context).secondBackgroundColor.withOpacity(0.9)),
      text: text,
      svg: svg,
      onTap: onTap,
    );
  }
}
