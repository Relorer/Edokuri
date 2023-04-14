// 🐦 Flutter imports:
// ignore_for_file: prefer_const_constructors

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_app_bar.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_book_list.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_books_section_header.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_screen_loading.dart';
import 'package:edokuri/src/pages/home_page/utils/app_bar.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingCustomScrollView(
      slivers: [
        LibraryAppBar(appBarHeight: getAppBarHeight(context)),
        const LibraryScreenLoading(),
        const LibraryBooksSectionHeader(),
        const LibraryBookList()
      ],
    );
  }
}
