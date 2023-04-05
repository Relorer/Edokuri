// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageTextForm extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const SettingsPageTextForm(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: doubleDefaultMargin),
      child: TextFormFieldDefault(
        controller: controller,
        labelText: labelText,
      ),
    );
  }
}
