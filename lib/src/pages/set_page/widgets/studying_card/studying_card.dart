// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/ellipsis_text.dart';
import 'package:edokuri/src/core/widgets/simple_card.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class StudyingCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String svg;
  final void Function()? onTap;

  const StudyingCard(
      {super.key,
      required this.title,
      this.onTap,
      required this.subTitle,
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
                child: SvgPicture.asset(
                  svg,
                  colorFilter:
                      const ColorFilter.mode(savedWord, BlendMode.srcIn),
                ),
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
                      subTitle,
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
