import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:swipable_stack/swipable_stack.dart';

class LearnPage extends StatefulWidget {
  final List<Record> records;

  const LearnPage({Key? key, required this.records}) : super(key: key);

  @override
  LearnPageState createState() {
    return LearnPageState();
  }
}

class LearnPageState extends State<LearnPage> with WidgetsBindingObserver {
  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void didChangeMetrics() {
    if (mounted) {
      setUpBarReaderStyles(context);
    }
    super.didChangeMetrics();
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Theme.of(context).secondBackgroundColor,
        title: Center(child: Text("1/2")),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: 0.1,
              backgroundColor:
                  Theme.of(context).paleElementColor.withOpacity(0.3),
            ),
            Expanded(
              child: SwipableStack(
                swipeAnchor: SwipeAnchor.top,
                dragStartCurve: Curves.linear,
                rewindAnimationCurve: Curves.fastOutSlowIn,
                cancelAnimationCurve: Curves.fastOutSlowIn,
                detectableSwipeDirections: const {
                  SwipeDirection.right,
                  SwipeDirection.left,
                },
                controller: _controller,
                stackClipBehaviour: Clip.hardEdge,
                onSwipeCompleted: (index, direction) {
                  if (kDebugMode) {
                    print('$index, $direction');
                  }
                },
                horizontalSwipeThreshold: 0.7,
                verticalSwipeThreshold: 0.7,
                overlayBuilder: (context, properties) {
                  final opacity = min(properties.swipeProgress, 1.0);
                  return Padding(
                    padding: const EdgeInsets.all(doubleDefaultMargin),
                    child: Opacity(
                      opacity: opacity,
                      child: properties.direction == SwipeDirection.right
                          ? Container(
                              child: const Center(
                                  child: Text(
                                "Know",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: const Color(0xff14B220),
                                    fontWeight: FontWeight.bold),
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(defaultRadius)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: defaultMargin,
                                      color: Theme.of(context)
                                          .paleElementColor
                                          .withOpacity(0.4),
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 5),
                                    ),
                                  ]),
                            )
                          : Container(
                              child: const Center(
                                  child: Text(
                                "Still learning",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: savedWord,
                                    fontWeight: FontWeight.bold),
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(defaultRadius)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: defaultMargin,
                                      color: Theme.of(context)
                                          .paleElementColor
                                          .withOpacity(0.4),
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 5),
                                    ),
                                  ]),
                            ),
                    ),
                  );
                },
                builder: (context, properties) {
                  final itemIndex = properties.index % widget.records.length;

                  return Padding(
                    padding: const EdgeInsets.all(doubleDefaultMargin),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(defaultRadius)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: defaultMargin,
                                    color: Theme.of(context)
                                        .paleElementColor
                                        .withOpacity(0.4),
                                    spreadRadius: 0.0,
                                    offset: const Offset(0, 5),
                                  ),
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: Column(children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        doubleDefaultMargin),
                                    child: Center(
                                      child: AutoSizeText(
                                        widget.records[itemIndex].original,
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(Icons.keyboard),
                                        onPressed: () {
                                          print("test");
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: doubleDefaultMargin,
                                )
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
