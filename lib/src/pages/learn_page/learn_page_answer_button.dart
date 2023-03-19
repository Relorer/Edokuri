// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';

class LearnPageAnswerButton extends StatelessWidget {
  final String topText;
  final String bottomText;
  final void Function()? onTap;
  final Color color;

  const LearnPageAnswerButton(
      {super.key,
      required this.topText,
      required this.bottomText,
      this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      color: Theme.of(context).secondBackgroundColor,
      child: SizedBox(
        height: 55,
        child: InkWell(
          highlightColor: (Colors.white).withAlpha(40),
          splashColor: (Colors.white).withAlpha(30),
          onTap: onTap,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  topText,
                  style: Theme.of(context).sectorTitleStye.copyWith(
                      color: color, fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Text(
                  bottomText.toUpperCase(),
                  style:
                      Theme.of(context).sectorTitleStye.copyWith(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
