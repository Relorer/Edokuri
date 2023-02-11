import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/core/widgets/section_headers/section_header_text.dart';
import 'package:freader/src/pages/set_editing_page/set_editign_page.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';

class SetsSectionHeader extends StatelessWidget {
  const SetsSectionHeader({super.key});

  _creatNewSet(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => const SetEditingPage(),
          ),
        )
        .then((value) =>
            setUpBarDefaultStyles(Theme.of(context).secondBackgroundColor));
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeaderText(
      leftText: "Sets",
      menuDialogChildren: [
        ButtonWithIcon(
          text: "Creat new set",
          onTap: () => _creatNewSet(context),
          svg: createSvg,
        ),
      ],
    );
  }
}
