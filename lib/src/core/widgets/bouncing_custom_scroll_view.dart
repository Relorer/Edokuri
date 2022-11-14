import 'dart:ui';

import 'package:flutter/widgets.dart';

class BouncingCustomScrollView extends StatelessWidget {
  final List<Widget> slivers;
  final ScrollController? controller;

  const BouncingCustomScrollView(
      {super.key, required this.slivers, this.controller});

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
      ),
    );
  }
}
