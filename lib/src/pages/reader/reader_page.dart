import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/translator_controller/translator_controller.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view.dart';
import 'package:freader/src/pages/reader/widgets/reader_footer_panel.dart';
import 'package:freader/src/pages/reader/widgets/reader_head_panel.dart';
import 'package:freader/src/pages/reader/widgets/reader_page_sliding_up_panel.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_card.dart';
import 'package:freader/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:provider/provider.dart';
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
  late DBController db;
  late ReaderController reader;
  late TranslatorController translator;

  late Book book;

  Record? record;
  final PanelController panelController = PanelController();
  bool blockBody = false;

  late Orientation _currentOrientation;
  final _containerKey = GlobalKey();

  @override
  initState() {
    book = widget.book;

    db = context.read<DBController>();
    reader = context.read<ReaderController>();
    translator = context.read<TranslatorController>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _currentOrientation = MediaQuery.of(context).orientation;
      _loadContent(context);
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    EasyDebounce.debounce('load-content', const Duration(seconds: 1), () {
      setUpBarReaderStyles(context);
      final newOrientation = MediaQuery.of(context).orientation;
      if (_currentOrientation != newOrientation) {
        _loadContent(context);
        _currentOrientation = newOrientation;
      }
    });

    super.didChangeMetrics();
  }

  _loadContent(BuildContext context) {
    final pageSize =
        (_containerKey.currentContext?.findRenderObject() as RenderBox).size;

    reader.loadContent(book, pageSize, Theme.of(context).readerPageTextStyle);
  }

  _tapOnWordHandler(String word) async {
    if (word.isEmpty) return;

    await panelController.close().then((value) => setState(() {
          FocusScope.of(context).unfocus();
          blockBody = true;
        }));

    Future.delayed(
        Duration(milliseconds: panelController.isPanelClosed ? 0 : 200),
        (() async {
      final temp = db.getRecord(word);
      record = temp != null && temp.translations.isNotEmpty
          ? temp
          : await context.read<TranslatorController>().translate(word, "");
      setState(() {});
      if (record != null) {
        panelController.open();
      }
    }));
  }

  _panelCloseHandler() {
    if (record == null) return;
    if (record!.translations.any((element) => element.selected)) {
      db.putRecord(record!);
    } else if (!record!.known && record!.id > 0) {
      db.removeRecord(record!);
    }
    setState(() {
      record = null;
      blockBody = false;
    });
  }

  @override
  void dispose() {
    reader.savePosition(book);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return TapOnWordHandlerProvider(
      tapOnWordHandler: _tapOnWordHandler,
      child: Scaffold(
        body: ReaderPageSlidingUpPanel(
          controller: panelController,
          panelCloseHandler: _panelCloseHandler,
          blockBody: blockBody,
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
                  const ReaderFooterPanel(),
                ],
              ),
            ),
          ),
          panelBuilder: (ScrollController sc) => record == null
              ? Container()
              : RecordInfoCard(
                  record: record!,
                  scrollController: sc,
                ),
        ),
      ),
    );
  }
}
