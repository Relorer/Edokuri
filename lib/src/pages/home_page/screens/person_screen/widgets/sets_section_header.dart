import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/section_header.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class SetsSectionHeader extends StatelessWidget {
  const SetsSectionHeader({super.key});

  _creatNewSet(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      leftText: "Sets",
      menuDialogChildren: [
        ButtonWithIcon(
          text: "Creat new set",
          onTap: () => _creatNewSet(context),
          svg: createSvg,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultMargin, horizontal: doubleDefaultMargin),
          child: Text(
            LocaleKeys.sort_by.tr(),
            style: Theme.of(context).dialogTextStylePale,
          ),
        ),
        const SortTypesList(),
      ],
    );
  }
}
