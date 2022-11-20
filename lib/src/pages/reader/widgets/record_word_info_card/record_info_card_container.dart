import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoCardContainer extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;

  const RecordInfoCardContainer(
      {super.key, required this.scrollController, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: doubleDefaultMargin * 2,
          horizontal: doubleDefaultMargin - 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
          boxShadow: [
            BoxShadow(
              blurRadius: defaultMargin,
              color: Theme.of(context).paleElementColor.withOpacity(0.2),
            ),
          ]),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
          child: child,
        ),
      ),
    );
  }
}
