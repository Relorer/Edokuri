// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header_text.dart';
import 'package:edokuri/src/pages/set_editing_page/set_editign_page.dart';
import 'package:edokuri/src/theme/svgs.dart';

class SetsSectionHeader extends StatelessWidget {
  const SetsSectionHeader({super.key});

  _creatNewSet(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SetEditingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeaderText(
      leftText: "Sets",
      menuDialogChildren: [
        ButtonWithIcon(
          text: "Create new set",
          onTap: () => _creatNewSet(context),
          svg: createSvg,
        ),
      ],
    );
  }
}
