// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';

class TextFormFieldDefault extends StatelessWidget {
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? labelText;

  const TextFormFieldDefault(
      {super.key, this.controller, this.labelText, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: Theme.of(context).secondBackgroundColor,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hoverColor: Theme.of(context).secondBackgroundColor,
        fillColor: Theme.of(context).secondBackgroundColor,
        prefixIconColor: Theme.of(context).secondBackgroundColor,
        focusColor: Theme.of(context).secondBackgroundColor,
        suffixIconColor: Theme.of(context).secondBackgroundColor,
        iconColor: Theme.of(context).secondBackgroundColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).secondBackgroundColor.withOpacity(0.6),
              width: 0.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).secondBackgroundColor.withOpacity(0.6),
              width: 0.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
      ),
    );
  }
}
