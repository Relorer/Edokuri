import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/core/widgets/ellipsis_text.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class StudyingCard extends StatelessWidget {
  final String title;
  final String subTitile;
  final String svg;
  final void Function()? onTap;

  const StudyingCard(
      {super.key,
      required this.title,
      this.onTap,
      required this.subTitile,
      required this.svg});

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
          child: Row(
            children: [
              Center(
                child: SvgPicture.asset(svg, color: savedWord),
              ),
              const SizedBox(
                width: doubleDefaultMargin,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EllipsisText(
                      title,
                      style: Theme.of(context).bookTitleStyle,
                    ),
                    EllipsisText(
                      subTitile,
                      style: Theme.of(context).cardSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
