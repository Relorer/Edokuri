import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/core/widgets/default_bottom_sheet.dart';
import 'package:freader/src/theme/svgs.dart';

class RecordCardDialog extends StatelessWidget {
  final VoidCallback? openRecord;
  final VoidCallback? removeSet;

  const RecordCardDialog({super.key, this.openRecord, this.removeSet});

  @override
  Widget build(BuildContext context) {
    return DefaultBottomSheet(children: [
      ButtonWithIcon(
        text: "Open info",
        svg: bookSvg,
        onTap: openRecord,
      ),
      ButtonWithIcon(
        text: LocaleKeys.delete.tr(),
        svg: deleteSvg,
        onTap: removeSet,
      ),
    ]);
  }
}
