import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/default_card_container.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoCardContainer extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;

  const RecordInfoCardContainer(
      {super.key, required this.scrollController, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: defaultMargin,
          bottom: doubleDefaultMargin,
          left: doubleDefaultMargin - 1,
          right: doubleDefaultMargin - 1),
      child: DefaultCardContainer(
        SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
            child: child,
          ),
        ),
      ),
    );
  }
}
