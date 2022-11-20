import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/reading_timer_controller/reading_timer_controller.dart';
import 'package:freader/src/controllers/translator_controller/translate_source.dart';
import 'package:freader/src/controllers/translator_controller/translator_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view.dart';
import 'package:freader/src/pages/reader/widgets/reader_footer_panel.dart';
import 'package:freader/src/pages/reader/widgets/reader_head_panel.dart';
import 'package:freader/src/pages/reader/widgets/reader_page_sliding_up_panel.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_card_container.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_card_content.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_card_skeleton.dart';
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
  late DBController _db;
  late ReaderController reader;
  late ReadingTimerController readerTimer;
  late TranslatorController _translator;

  Record? _record;
  final PanelController _panelController = PanelController();
  bool _blockBody = false;

  late Orientation _currentOrientation;
  final _containerKey = GlobalKey();

  DateTime? startReading;

  @override
  initState() {
    _db = context.read<DBController>();
    reader = getIt<ReaderController>(param1: widget.book);
    readerTimer = getIt<ReadingTimerController>(param1: widget.book);
    _translator = context.read<TranslatorController>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _currentOrientation = MediaQuery.of(context).orientation;
      _loadContent(context);
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();

    readerTimer.startReadingTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        readerTimer.stopReadingTimer();
        break;
      case AppLifecycleState.resumed:
        readerTimer.startReadingTimer();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeMetrics() {
    EasyDebounce.debounce('load-content', const Duration(seconds: 1), () {
      if (mounted) {
        setUpBarReaderStyles(context);
        final newOrientation = MediaQuery.of(context).orientation;
        if (_currentOrientation != newOrientation) {
          _loadContent(context);
          _currentOrientation = newOrientation;
        }
      }
    });

    super.didChangeMetrics();
  }

  _loadContent(BuildContext context) {
    final pageSize =
        (_containerKey.currentContext?.findRenderObject() as RenderBox).size;

    reader.loadContent(pageSize, Theme.of(context).readerPageTextStyle);
  }

  _tapOnWordHandler(String word, int indexOnPage) async {
    if (word.isEmpty) return;

    await _panelController.close().then((value) => setState(() {
          FocusScope.of(context).unfocus();
          _blockBody = true;
        }));

    Future.delayed(
        Duration(milliseconds: _panelController.isPanelClosed ? 0 : 200),
        (() async {
      _panelController.open();
      final temp = _db.getRecord(word);
      _record = temp != null && temp.translations.isNotEmpty
          ? temp
          : await _translator.translate(word);

      if (_record != null) {
        if (indexOnPage > -1) {
          final sentence = reader.getSentence(indexOnPage);
          if (sentence.length > 1 && !_record!.sentences.contains(sentence)) {
            _record!.sentences.add(sentence);
          }
        }
      }

      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {});
    }));
  }

  _panelCloseHandler() {
    if (_record == null) return;
    if (_record!.translations.any((element) => element.selected)) {
      _record!.translations.removeWhere(
          (element) => element.source == userSource && !element.selected);
      _record!.known = false;
      _db.putRecord(_record!);
    } else if (!_record!.known && _record!.id > 0) {
      _db.removeRecord(_record!);
    }
    setState(() {
      _record = null;
      _blockBody = false;
    });
  }

  @override
  void dispose() {
    reader.savePosition();
    readerTimer.stopReadingTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return MultiProvider(
      providers: [
        Provider<ReaderController>(create: (_) => reader),
      ],
      child: TapOnWordHandlerProvider(
        tapOnWordHandler: _tapOnWordHandler,
        child: Scaffold(
          body: ReaderPageSlidingUpPanel(
            controller: _panelController,
            panelCloseHandler: _panelCloseHandler,
            blockBody: _blockBody,
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
            panelBuilder: (ScrollController sc) => RecordInfoCardContainer(
                scrollController: sc,
                child: AnimatedSwitcher(
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  duration: const Duration(milliseconds: 200),
                  child: _record == null
                      ? const RecordInfoCardSkeleton()
                      : RecordInfoCardContent(record: _record!),
                )),
          ),
        ),
      ),
    );
  }
}
