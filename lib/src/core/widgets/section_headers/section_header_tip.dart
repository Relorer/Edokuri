// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:just_the_tooltip/just_the_tooltip.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SectionHeaderWithTip extends StatelessWidget {
  final Widget leftChild;
  final String tip;

  const SectionHeaderWithTip(
      {Key? key, required this.leftChild, required this.tip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = JustTheController();
    return SliverSingleChild(Padding(
      padding: const EdgeInsets.all(doubleDefaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: leftChild),
          JustTheTooltip(
            controller: controller,
            preferredDirection: AxisDirection.up,
            backgroundColor: Theme.of(context).secondBackgroundColor,
            content: Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: Text(
                tip,
                style: const TextStyle(
                    fontSize: 14, color: white, fontWeight: FontWeight.bold),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.question_mark_outlined, size: 20),
              color: Theme.of(context).lightGrayColor,
              onPressed: () {},
            ),
          )
        ],
      ),
    ));
  }
}
