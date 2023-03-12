// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class SliverSingleChild extends StatelessWidget {
  final Widget child;

  const SliverSingleChild(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) => child,
            childCount: 1));
  }
}
