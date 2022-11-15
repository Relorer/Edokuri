import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/controllers/reader_controller/provider_reader_controller.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/translator_controller/provider_translator_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view.dart';
import 'package:freader/src/pages/reader/widgets/reader_footer_panel.dart';
import 'package:freader/src/pages/reader/widgets/reader_head_panel.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_card.dart';
import 'package:freader/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  PanelController panelController = PanelController();
  late DBController dbController;

  late Orientation _currentOrientation;

  late Book book;

  Record? record;

  final _containerKey = GlobalKey();

  @override
  initState() {
    book = widget.book;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dbController = ProviderDbController.ctr(context);
      _currentOrientation = MediaQuery.of(context).orientation;
      _loadContent();
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
        if (_currentOrientation != MediaQuery.of(context).orientation) {
          _loadContent();
          _currentOrientation = MediaQuery.of(context).orientation;
        }
      },
    );
    super.didChangeMetrics();
  }

  _loadContent() {
    final pageSize =
        (_containerKey.currentContext?.findRenderObject() as RenderBox).size;

    readerController.loadContent(
        book, pageSize, Theme.of(context).readerPageTextStyle);
  }

  _tapOnWordHandler(String word) async {
    if (word.isEmpty) return;

    panelController.close();

    Future.delayed(
        Duration(milliseconds: panelController.isPanelClosed ? 0 : 200),
        (() async {
      record =
          await ProviderTranslatorController.ctr(context).translate(word, "");
      setState(() {});
      if (record != null) {
        panelController.open();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return ProviderReaderController.setController(
      controller: readerController,
      child: TapOnWordHandlerProvider(
        tapOnWordHandler: _tapOnWordHandler,
        child: Scaffold(
          body: SlidingUpPanel(
            onPanelClosed: (() {
              setState(() {
                record = null;
              });
            }),
            controller: panelController,
            minHeight: 0,
            renderPanelSheet: false,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10.0,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              )
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(defaultRadius),
              topRight: Radius.circular(defaultRadius),
            ),
            maxHeight: MediaQuery.of(context).size.height * 0.75,
            color: Theme.of(context).colorScheme.background,
            panelBuilder: (ScrollController sc) => record == null
                ? Container()
                : RecordInfoCard(
                    record: record!,
                    scrollController: sc,
                  ),
            body: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.background,
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
              ),
            ),
          ),
        ),
      ),
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
