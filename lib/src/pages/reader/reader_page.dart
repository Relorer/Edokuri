import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/controllers/reader_controller/provider_reader_controller.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view.dart';
import 'package:freader/src/pages/reader/widgets/reader_footer_panel.dart';
import 'package:freader/src/pages/reader/widgets/reader_head_panel.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';

class ReaderPage extends StatefulWidget {
  final Book book;

  const ReaderPage({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  ReaderPageState createState() {
    return ReaderPageState();
  }
}

class ReaderPageState extends State<ReaderPage> with WidgetsBindingObserver {
  ReaderController readerController = ReaderController();
  late DBController dbController;

  late Book book;

  final _containerKey = GlobalKey();

  @override
  initState() {
    book = widget.book;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      dbController = ProviderDbController.ctr(context);
      loadContent();
    });

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setUpBarReaderStyles(context);
        loadContent();
      },
    );
    super.didChangeMetrics();
  }

  loadContent() {
    final pageSize =
        (_containerKey.currentContext?.findRenderObject() as RenderBox).size;

    readerController.loadContent(
        book, pageSize, Theme.of(context).readerPageTextStyle);
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return ProviderReaderController.setController(
      controller: readerController,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Column(
              children: [
                const ReaderHeadPanel(),
                Expanded(
                  key: _containerKey,
                  child: const ReaderContentView(),
                ),
                ReaderFooterPanel(
                  currentPart: readerController.currentChapter + 1,
                  partCount: book.chapters.length,
                ),
              ],
            ),
          )),
    );
  }

  _savePosition() {
    book.currentChapter = readerController.currentChapter;
    book.currentPositionInChapter =
        readerController.getCurrentPositionInChapter();

    book.currentCompletedChapter = readerController.currentCompletedChapter;
    book.currentCompletedPositionInChapter =
        readerController.getCurrentCompletedPositionInChapter();
    dbController.putBook(book);
  }

  @override
  void dispose() {
    _savePosition();
    super.dispose();
  }
}
