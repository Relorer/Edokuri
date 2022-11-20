import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/section_header.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_section_dialog/books_section_dialog.dart';

class LibraryBooksSectionHeader extends StatelessWidget {
  const LibraryBooksSectionHeader({super.key});

  void menuButtonHandler(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const BooksSectionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => SectorTitleWidget(
                  leftText: LocaleKeys.library.tr(),
                  onPressed: () => menuButtonHandler(context),
                ),
            childCount: 1));
  }
}
