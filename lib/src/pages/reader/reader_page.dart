// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_debounce/easy_debounce.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:edokuri/src/controllers/common/reading_timer_controller/reading_timer_controller.dart';
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_footer_panel.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_head_panel.dart';
import 'package:edokuri/src/theme/theme.dart';

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
  late ReaderController reader;
  late ReadingTimerController readerTimer;

  late Orientation _currentOrientation;
  final _containerKey = GlobalKey();

  DateTime? startReading;

  @override
  initState() {
    reader = getIt<ReaderController>(param1: widget.book);
    readerTimer = getIt<ReadingTimerController>(param1: widget.book);

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

  @override
  void dispose() {
    reader.savePosition();
    readerTimer.stopReadingTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ReaderController>(create: (_) => reader),
      ],
      child: RecordWithInfoCard(
        bottomPadding: 0,
        showTranslationSourceSentences: false,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Theme.of(context).colorScheme.background),
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 0,
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
                      const ReaderFooterPanel(),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
