import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

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
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
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
