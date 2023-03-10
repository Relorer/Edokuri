// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

class BouncingCustomScrollView extends StatelessWidget {
  final List<Widget> slivers;
  final ScrollController? controller;
  final bool revers;

  const BouncingCustomScrollView(
      {super.key, required this.slivers, this.controller, this.revers = false});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
          physics: const BouncingScrollPhysics()),
      child: CustomScrollView(
        controller: controller,
        slivers: slivers,
        reverse: revers,
      ),
    );
  }
}
