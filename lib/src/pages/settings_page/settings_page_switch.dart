// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageSwitch extends StatelessWidget {
  final String text;
  final String svg;
  final bool colorFilter;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsPageSwitch(
      {super.key,
      this.onChanged,
      required this.svg,
      required this.text,
      required this.value,
      this.colorFilter = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        color: Colors.transparent,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: defaultRadius),
          child: Row(children: [
            SizedBox(
              width: 24,
              child: Center(
                child: SvgPicture.asset(
                  svg,
                  colorFilter: colorFilter
                      ? ColorFilter.mode(
                          Theme.of(context).lightGrayColor, BlendMode.srcIn)
                      : null,
                ),
              ),
            ),
            const SizedBox(
              width: doubleDefaultMargin,
            ),
            Text(text,
                style: Theme.of(context).dialogTextStyleBright.copyWith(
                    color: Theme.of(context)
                        .secondBackgroundColor
                        .withOpacity(0.9))),
            const Expanded(
              child: SizedBox(),
            ),
            Switch(
              value: value,
              activeColor: orange,
              onChanged: onChanged,
            )
          ]),
        ),
      ),
    );
  }
}
