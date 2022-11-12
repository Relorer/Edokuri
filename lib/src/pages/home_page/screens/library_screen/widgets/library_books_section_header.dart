import 'package:flutter/material.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/books_section_dialog.dart';

import 'sector_title_widget.dart';

class LibraryBooksSectionHeader extends StatelessWidget {
  const LibraryBooksSectionHeader({super.key});

  void menuButtonHandler(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return const BooksSectionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: SectorTitleWidget(
                    leftText: "Library",
                    onPressed: () => menuButtonHandler(context),
                  ),
                ),
            childCount: 1));
  }
}
