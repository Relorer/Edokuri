// 🐦 Flutter imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:edokuri/src/theme/theme_consts.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPageTextForm extends StatelessWidget {
  final String labelText;
  final String hint;
  final TextEditingController controller;
  final String svg;
  final bool colorFilter;

  const SettingsPageTextForm(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hint,
      required this.svg,
      this.colorFilter = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: doubleDefaultMargin),
          child: Row(
            children: [
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
              Text(labelText,
                  style: Theme.of(context).dialogTextStyleBright.copyWith(
                      color: Theme.of(context)
                          .secondBackgroundColor
                          .withOpacity(0.9))),
              const SizedBox(width: doubleDefaultMargin),
              Expanded(
                  child: TextFormField(
                controller: controller,
                cursorColor: Theme.of(context).secondBackgroundColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide.none,
                  ),
                  isCollapsed: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(defaultMargin),
                  hoverColor: Theme.of(context).secondBackgroundColor,
                  fillColor: white,
                  filled: true,
                  prefixIconColor: Theme.of(context).secondBackgroundColor,
                  focusColor: Theme.of(context).secondBackgroundColor,
                  suffixIconColor: Theme.of(context).secondBackgroundColor,
                  iconColor: Theme.of(context).secondBackgroundColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: hint,
                ),
              )),
            ],
          )),
    );
  }
}
