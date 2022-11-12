import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/controllers/reader_controller/provider_reader_controller.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/core/circular_progress_indicator_pale.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/reader/widgets/reader_chapter_progress_bar.dart';
import 'package:freader/src/pages/reader/widgets/reader_page_view_widget.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:need_resume/need_resume.dart';

class ReaderPage extends StatefulWidget {
  final Book book;

  const ReaderPage({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  _ReaderPageState createState() {
    return _ReaderPageState();
  }
}

class _ReaderPageState extends ResumableState<ReaderPage>
    with WidgetsBindingObserver {
  ReaderController readerController = ReaderController();

  late Book book;
  late DBController dbController;

  late PageController pageController;

  final _containerKey = GlobalKey();

  void _savePosition() {
    book.currentChapter = readerController.currentChapter;
    book.currentPositionInChapter =
        readerController.getCurrentPositionInChapter();

    book.currentCompletedChapter = readerController.currentCompletedChapter;
    book.currentCompletedPositionInChapter =
        readerController.getCurrentCompletedPositionInChapter();
    dbController.putBook(book);
  }

  @override
  void initState() {
    book = widget.book;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final pageSize =
          (_containerKey.currentContext?.findRenderObject() as RenderBox).size;
      readerController.loadContent(book, pageSize);
      dbController = ProviderDbController.ctr(context);
    });
    super.initState();
    pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarIconBrightness: Brightness.dark,
        ));
        final pageSize =
            (_containerKey.currentContext?.findRenderObject() as RenderBox)
                .size;

        readerController.loadContent(book, pageSize);
      },
    );
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    _savePosition();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.background,
      statusBarColor: Theme.of(context).colorScheme.background,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ProviderReaderController.setController(
      controller: readerController,
      child: Scaffold(
          body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(
                                color: Theme.of(context).paleElementColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(child: ReaderChapterProgressBar()),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SizedBox(
                        width: double.maxFinite,
                        key: _containerKey,
                        child: Observer(
                          builder: (context) {
                            if (readerController.chaptersContent.isEmpty) {
                              return const CircularProgressIndicatorPale();
                            }
                            return ReaderChapterPageView(
                              onPageChanged:
                                  readerController.pageChangedHandler,
                              pageController: PageController(
                                  initialPage:
                                      readerController.currentPageIndex),
                              pagesContent: readerController.chaptersContent
                                  .expand((x) => x)
                                  .toList(),
                            );
                          },
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Observer(builder: (_) {
                    return Text(
                      "Part ${readerController.currentChapter + 1} of ${book.chapters.length}",
                      style: TextStyle(
                          color: Theme.of(context).paleElementColor,
                          fontSize: 12),
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
