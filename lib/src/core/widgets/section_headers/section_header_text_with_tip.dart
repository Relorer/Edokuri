// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/section_headers/section_header_tip.dart';
import 'package:edokuri/src/theme/theme.dart';

// 📦 Package imports:

class SectionHeaderTextWithTip extends StatelessWidget {
  final String leftText;
  final String? tip;

  const SectionHeaderTextWithTip({Key? key, required this.leftText, this.tip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionHeaderWithTip(
      leftChild: Text(
        leftText,
        style: Theme.of(context).sectorTitleStye,
      ),
      tip: tip ?? "",
    );
  }
}
