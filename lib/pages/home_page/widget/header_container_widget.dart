import 'package:flutter/material.dart';
import 'package:freader/theme.dart';

class HeaderContainerWidget extends StatelessWidget {
  final List<Widget> children;

  const HeaderContainerWidget({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).secondBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
          children: children,
        ));
  }
}
