// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageDropListValue {
  final String value;
  final String text;

  SettingsPageDropListValue(this.value, this.text);
}

class SettingsPageDropList extends StatelessWidget {
  final String text;
  final String svg;
  final bool colorFilter;
  final String value;
  final List<SettingsPageDropListValue> values;
  final ValueChanged<String>? onChanged;

  const SettingsPageDropList(
      {super.key,
      this.onChanged,
      required this.svg,
      required this.text,
      required this.value,
      required this.values,
      this.colorFilter = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            const Expanded(child: SizedBox()),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                items: values
                    .map((item) => DropdownMenuItem<String>(
                          value: item.value,
                          child: Text(
                            item.text,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: value,
                onChanged: (value) {
                  onChanged!(value.toString());
                },
                buttonStyleData: const ButtonStyleData(
                  elevation: 0,
                  height: 40,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  openMenuIcon: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  iconSize: 14,
                  iconEnabledColor: lightGray,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 180,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(defaultRadius)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: Color.fromRGBO(0, 0, 0, 0.075),
                      )
                    ],
                  ),
                  elevation: 0,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 26,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
