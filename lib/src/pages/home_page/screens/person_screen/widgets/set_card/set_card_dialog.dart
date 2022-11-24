import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/core/widgets/default_bottom_sheet.dart';
import 'package:freader/src/theme/svgs.dart';

class SetCardDialog extends StatelessWidget {
  final VoidCallback? openSet;
  final VoidCallback? openEditingSet;
  final VoidCallback? removeSet;

  const SetCardDialog(
      {super.key, this.openSet, this.removeSet, this.openEditingSet});

  @override
  Widget build(BuildContext context) {
    return DefaultBottomSheet(children: [
      ButtonWithIcon(
        text: "Open set",
        svg: goToSetSvg,
        onTap: openSet,
      ),
      ButtonWithIcon(
        text: "Edit set",
        svg: editSvg,
        onTap: openEditingSet,
      ),
      ButtonWithIcon(
        text: LocaleKeys.delete.tr(),
        svg: deleteSvg,
        onTap: removeSet,
      ),
    ]);
  }
}
