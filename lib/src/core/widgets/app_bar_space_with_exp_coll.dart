import 'dart:math';

import 'package:flutter/material.dart';
import 'package:edokuri/src/theme/theme.dart';

class AppBarSpaceWithCollapsedAndExpandedParts extends StatelessWidget {
  final Widget? collapsed;
  final Widget? expanded;
  final Widget? always;

  const AppBarSpaceWithCollapsedAndExpandedParts(
      {Key? key, this.collapsed, this.expanded, this.always})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final transform =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(transform);

        return Container(
          color: Theme.of(context).secondBackgroundColor,
          child: Stack(
            children: [
              IgnorePointer(
                ignoring: opacity == 0,
                child: Opacity(
                  opacity: opacity,
                  child: expanded,
                ),
              ),
              IgnorePointer(
                  ignoring: opacity == 1,
                  child: Opacity(opacity: 1 - opacity, child: collapsed)),
              Container(child: always),
            ],
          ),
        );
      },
    );
  }
}
