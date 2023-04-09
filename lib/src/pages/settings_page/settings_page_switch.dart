// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

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
    final onChangeWithImpact = onChanged == null
        ? null
        : (value) {
            HapticFeedback.mediumImpact();
            onChanged!(value);
          };

    return GestureDetector(
      onTap: () {
        if (onChangeWithImpact != null) {
          onChangeWithImpact(!value);
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
            onChangeWithImpact != null
                ? FlutterSwitch(
                    value: value,
                    width: 42,
                    height: 24,
                    padding: 5.0,
                    toggleSize: 14,
                    activeColor: orange,
                    inactiveColor: const Color(0xFFE1E4E6),
                    inactiveToggleColor: const Color(0xFFE1E4E6),
                    onToggle: onChangeWithImpact,
                    inactiveToggleBorder: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  )
                : const SizedBox()
          ]),
        ),
      ),
    );
  }
}
