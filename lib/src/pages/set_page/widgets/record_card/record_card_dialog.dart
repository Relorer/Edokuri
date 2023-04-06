// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/default_bottom_sheet.dart';
import 'package:edokuri/src/theme/svgs.dart';

class RecordCardDialog extends StatelessWidget {
  final VoidCallback? openRecord;
  final VoidCallback? removeSet;
  final VoidCallback? resetProgress;
  final VoidCallback? updateTranslation;

  const RecordCardDialog(
      {super.key,
      this.openRecord,
      this.removeSet,
      this.resetProgress,
      this.updateTranslation});

  @override
  Widget build(BuildContext context) {
    return DefaultBottomSheet(children: [
      ButtonWithIcon(
        text: "Open info",
        svg: bookSvg,
        onTap: openRecord,
      ),
      ButtonWithIcon(
        text: "Reset progress",
        svg: loopSvg,
        onTap: resetProgress,
      ),
      ButtonWithIcon(
        text: "Update translation",
        svg: loop2Svg,
        onTap: updateTranslation,
      ),
      ButtonWithIcon(
        text: LocaleKeys.delete.tr(),
        svg: deleteSvg,
        onTap: removeSet,
      ),
    ]);
  }
}
