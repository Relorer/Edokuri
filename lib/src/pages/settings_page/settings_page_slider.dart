// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageSlider extends StatelessWidget {
  final String text;
  final String? svg;
  final bool colorFilter;
  final double value;
  final ValueChanged<double>? onChanged;
  final double max;
  final double min;
  final String label;

  const SettingsPageSlider(
      {super.key,
      this.onChanged,
      this.svg,
      required this.text,
      required this.value,
      this.max = 1.0,
      this.min = 0.0,
      this.label = "",
      this.colorFilter = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: doubleDefaultMargin, vertical: defaultRadius),
        child: Row(children: [
          svg == null
              ? const SizedBox()
              : Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Center(
                        child: SvgPicture.asset(
                          svg!,
                          colorFilter: colorFilter
                              ? ColorFilter.mode(
                                  Theme.of(context).lightGrayColor,
                                  BlendMode.srcIn)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: doubleDefaultMargin,
                    ),
                  ],
                ),
          Text(text,
              style: Theme.of(context).dialogTextStyleBright.copyWith(
                  color: Theme.of(context)
                      .secondBackgroundColor
                      .withOpacity(0.9))),
          const SizedBox(
            width: doubleDefaultMargin,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                label.isEmpty
                    ? const SizedBox()
                    : Text(label,
                        style: TextStyle(
                            color: Theme.of(context).progressBarActiveColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 12)),
                Theme(
                  data: basicTheme(Theme.of(context).brightness)
                      .copyWith(useMaterial3: true),
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2,
                      showValueIndicator: ShowValueIndicator.always,
                      activeTrackColor:
                          Theme.of(context).progressBarActiveColor,
                      inactiveTrackColor: const Color(0xFFE1E4E6),
                      thumbColor: Theme.of(context).progressBarActiveColor,
                      disabledThumbColor:
                          Theme.of(context).progressBarActiveColor,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                          elevation: 0,
                          pressedElevation: 0),
                    ),
                    child: Slider(
                      value: value,
                      max: max,
                      min: min,
                      label: (value * 100).round().toString(),
                      onChanged: onChanged,
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
