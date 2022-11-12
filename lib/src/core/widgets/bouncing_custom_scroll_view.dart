import 'dart:ui';

import 'package:flutter/widgets.dart';

class BouncingCustomScrollView extends StatelessWidget {
  final List<Widget> slivers;

  const BouncingCustomScrollView({super.key, required this.slivers});

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
        slivers: slivers,
      ),
    );
  }
}
