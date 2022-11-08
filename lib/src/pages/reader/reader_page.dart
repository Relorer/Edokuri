import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/book_indexes.dart';
import 'package:freader/src/theme/theme.dart';

import 'widgets/reader_slider_widget.dart';

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
  final List<String> _pages = [];
  final _containerKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => _paginate());
    super.initState();
  }

  void _paginate() {
    final pageSize =
        (_containerKey.currentContext?.findRenderObject() as RenderBox).size;

    _pages.clear();

    var content = widget.book.chapters[3].content.replaceAll("\n", "\n\n");

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
        _pages.add(pageText);
        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + pageSize.height;
      }
    }

    final lastPageText = content.substring(currentPageStartIndex);
    setState(() {
      _pages.add(lastPageText);
    });
  }

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();

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
                            value: 7,
                            max: 25,
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
                    child: _pages.isEmpty
                        ? Container()
                        : ReaderSliderWidget(
                            pages: _pages,
                            carouselController: buttonCarouselController,
                            onPageChanged: ((index, reason) {}),
                          )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Chapter 75 of 586",
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

  @override
  void didUpdateWidget(covariant ReaderPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose");
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
      statusBarColor: Theme.of(context).secondBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));
    super.dispose();
  }
}

class WordIndexWithKey {
  final WordIndex wordIndex;
  final GlobalKey<State<StatefulWidget>> key;

  WordIndexWithKey(this.wordIndex, this.key);
}
