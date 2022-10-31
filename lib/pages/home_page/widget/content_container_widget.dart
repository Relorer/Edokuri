import 'package:flutter/material.dart';
import 'package:freader/theme.dart';

class ContentContainerWidget extends StatelessWidget {
  final List<Widget> children;

  const ContentContainerWidget({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: children,
        ));
  }
}
