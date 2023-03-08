import 'package:flutter/material.dart';
import 'package:edokuri/src/theme/theme.dart';

class TextFormFieldWithoutPaddings extends StatelessWidget {
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? labelText;

  const TextFormFieldWithoutPaddings(
      {super.key, this.controller, this.labelText, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      scrollPadding: EdgeInsets.zero,
      cursorColor: Theme.of(context).secondBackgroundColor,
      decoration: InputDecoration(
        hoverColor: Theme.of(context).secondBackgroundColor,
        fillColor: Theme.of(context).secondBackgroundColor,
        prefixIconColor: Theme.of(context).secondBackgroundColor,
        focusColor: Theme.of(context).secondBackgroundColor,
        suffixIconColor: Theme.of(context).secondBackgroundColor,
        iconColor: Theme.of(context).secondBackgroundColor,
        isDense: true,
        isCollapsed: true,
        border: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).secondBackgroundColor.withOpacity(0.2),
              width: 1.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: Theme.of(context).sectorTitleStye,
        labelText: labelText,
      ),
    );
  }
}
