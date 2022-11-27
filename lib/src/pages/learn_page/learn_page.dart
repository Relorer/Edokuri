import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/models/models.dart';
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

class LearnPageState extends State<LearnPage> {
  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

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
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SwipableStack(
                  detectableSwipeDirections: const {
                    SwipeDirection.right,
                    SwipeDirection.left,
                  },
                  controller: _controller,
                  stackClipBehaviour: Clip.none,
                  onSwipeCompleted: (index, direction) {
                    if (kDebugMode) {
                      print('$index, $direction');
                    }
                  },
                  horizontalSwipeThreshold: 0.8,
                  verticalSwipeThreshold: 0.8,
                  builder: (context, properties) {
                    final itemIndex = properties.index % widget.records.length;

                    return Stack(
                      children: [
                        Container(
                          child: Text("Sample No.${itemIndex + 1}"),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            // BottomButtonsRow(
            //   onSwipe: (direction) {
            //     _controller.next(swipeDirection: direction);
            //   },
            //   onRewindTap: _controller.rewind,
            //   canRewind: _controller.canRewind,
            // ),
          ],
        ),
      ),
    );
  }
}
