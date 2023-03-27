// 🐦 Flutter imports:
// ignore_for_file: prefer_const_constructors

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_app_bar.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_book_list.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/library_books_section_header.dart';
import 'package:edokuri/src/pages/home_page/utils/app_bar.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final bookRepository = getIt<BookRepository>();
      return BouncingCustomScrollView(
        slivers: [
          LibraryAppBar(appBarHeight: getAppBarHeight(context)),
          SliverSingleChild(Visibility(
              replacement: SizedBox(height: 3),
              visible: bookRepository.isLoading,
              child: LinearProgressIndicator(
                minHeight: 3,
                color: lightGray,
              ))),
          const LibraryBooksSectionHeader(),
          const LibraryBookList()
        ],
      );
    });
  }
}
