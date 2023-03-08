// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale_keys.g.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_chapter_progress_bar.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class ReaderHeadPanel extends StatelessWidget {
  const ReaderHeadPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: doubleDefaultMargin, vertical: defaultMargin),
      child: Row(
        children: [
          InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                LocaleKeys.close.tr(),
                style: Theme.of(context).readerHeadPanelTextStyle,
              )),
          const SizedBox(
            width: doubleDefaultMargin,
          ),
          const Expanded(child: ReaderChapterProgressBar()),
        ],
      ),
    );
  }
}
