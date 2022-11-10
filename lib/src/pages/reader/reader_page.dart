import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/core/circular_progress_indicator_pale.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/book_indexes.dart';
import 'package:freader/src/pages/reader/widgets/reader_page_view_widget.dart';
import 'package:freader/src/theme/theme.dart';

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

class _ReaderPageState extends State<ReaderPage> {
  late PageController pageController;

  Size? _pageSize;
  List<String> _pages = [];
  final _containerKey = GlobalKey();

  int chapter = 0;

  int get startChapter => chapter == 0 ? 0 : 1;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _pageSize =
            (_containerKey.currentContext?.findRenderObject() as RenderBox)
                .size;
      });
      setChapter(0);
    });
    super.initState();
    pageController = PageController(initialPage: startChapter);
  }

  void setChapter(int index) {
    setState(() {
      chapter = index;
      _pages = _paginate(_pageSize!, widget.book.chapters[chapter].content);
      if (pageController.hasClients) {
        pageController.jumpToPage(startChapter);
      }
    });
  }

  List<String> _paginate(Size pageSize, String content) {
    final result = <String>[];

    final textSpan = TextSpan(
        text: content,
        style: const TextStyle(fontSize: 19, wordSpacing: 2, height: 1.6));
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: pageSize.width,
    );

    List<LineMetrics> lines = textPainter.computeLineMetrics();
    double currentPageBottom = pageSize.height;
    int currentPageStartIndex = 0;
    int currentPageEndIndex = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;

      if (currentPageBottom < bottom) {
        currentPageEndIndex =
            textPainter.getPositionForOffset(Offset(left, top)).offset;
        final pageText =
            content.substring(currentPageStartIndex, currentPageEndIndex);
        result.add(pageText);
        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + pageSize.height;
      }
    }

    final lastPageText = content.substring(currentPageStartIndex);
    result.add(lastPageText);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.background,
      statusBarColor: Theme.of(context).colorScheme.background,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            color: Color(0xffF2A922),
                            backgroundColor: Colors.black12,
                          ),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                              activeTrackColor: Colors.transparent,
                              inactiveTrackColor: Colors.transparent,
                              disabledActiveTickMarkColor: Colors.transparent,
                              disabledActiveTrackColor: Colors.transparent,
                              disabledInactiveTickMarkColor: Colors.transparent,
                              disabledInactiveTrackColor: Colors.transparent,
                              disabledThumbColor: Color(0xffF2A922),
                              thumbShape:
                                  RoundSliderThumbShape(enabledThumbRadius: 5)),
                          child: Slider(
                            value: 1,
                            max: 20,
                            onChanged: null,
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                    width: double.maxFinite,
                    key: _containerKey,
                    child: _pageSize == null
                        ? const CircularProgressIndicatorPale()
                        : ReaderChapterPageView(
                            pageController: pageController,
                            pagesContent: _pages,
                            isFirstChapter: chapter == 0,
                            isLastChapter:
                                chapter > widget.book.chapters.length - 1,
                            moveNext: () {
                              setChapter(chapter + 1);
                            },
                            movePrev: () {
                              setChapter(chapter - 1);
                            })),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Chapter ${chapter + 1} of ${widget.book.chapters.length}",
                  style: TextStyle(color: Theme.of(context).paleElementColor),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class WordIndexWithKey {
  final WordIndex wordIndex;
  final GlobalKey<State<StatefulWidget>> key;

  WordIndexWithKey(this.wordIndex, this.key);
}
