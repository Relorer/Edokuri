// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/section_headers/section_header.dart';
import 'package:edokuri/src/theme/theme.dart';

class SectionHeaderText extends StatelessWidget {
  final String leftText;
  final List<Widget>? menuDialogChildren;

  const SectionHeaderText(
      {Key? key, required this.leftText, this.menuDialogChildren})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
        leftChild: Text(
          leftText,
          style: Theme.of(context).sectorTitleStye,
        ),
        menuDialogChildren: menuDialogChildren);
  }
}
