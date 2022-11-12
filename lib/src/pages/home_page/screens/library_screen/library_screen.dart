import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/library_app_bar.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/library_book_list.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/library_books_section_header.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight =
        min((MediaQuery.of(context).size.height - 110) * .3, 300);

    return BouncingCustomScrollView(
      slivers: [
        LibraryAppBar(appBarHeight: appBarHeight),
        const LibraryBooksSectionHeader(),
        const LibraryBookList()
      ],
    );
  }
}
