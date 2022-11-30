import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:swipable_stack/swipable_stack.dart';

class LearnSwipableStack extends StatelessWidget {
  final SwipableStackController? controller;
  final SwipableStackItemBuilder builder;
  final SwipeCompletionCallback? onSwipeCompleted;
  final Widget right;
  final Widget left;

  const LearnSwipableStack(
      {super.key,
      required this.builder,
      required this.left,
      required this.right,
      this.onSwipeCompleted,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return SwipableStack(
      onSwipeCompleted: onSwipeCompleted,
      swipeAnchor: SwipeAnchor.top,
      dragStartCurve: Curves.linear,
      rewindAnimationCurve: Curves.fastOutSlowIn,
      cancelAnimationCurve: Curves.fastOutSlowIn,
      detectableSwipeDirections: const {
        SwipeDirection.right,
        SwipeDirection.left,
      },
      controller: controller,
      stackClipBehaviour: Clip.hardEdge,
      horizontalSwipeThreshold: 0.7,
      verticalSwipeThreshold: 0.7,
      overlayBuilder: (context, properties) {
        final opacity = min(properties.swipeProgress, 1.0);
        return Padding(
          padding: const EdgeInsets.all(doubleDefaultMargin),
          child: Opacity(
            opacity: opacity,
            child: properties.direction == SwipeDirection.right ? right : left,
          ),
        );
      },
      builder: builder,
    );
  }
}
