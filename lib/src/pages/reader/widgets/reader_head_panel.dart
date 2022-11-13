import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freader/generated/locale_keys.g.dart';
import 'package:freader/src/pages/reader/widgets/reader_chapter_progress_bar.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class ReaderHeadPanel extends StatelessWidget {
  const ReaderHeadPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(doubleDefaultMargin),
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
