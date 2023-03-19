// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';

class LearnPageShowAnswerButton extends StatelessWidget {
  final void Function()? onTap;

  const LearnPageShowAnswerButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: Material(
        color: Theme.of(context).secondBackgroundColor,
        child: InkWell(
          highlightColor: (Colors.white).withAlpha(40),
          splashColor: (Colors.white).withAlpha(30),
          onTap: onTap,
          child: Center(
            child: Text(
              "Show answer",
              textAlign: TextAlign.center,
              style: Theme.of(context).dialogTextStyleBright,
            ),
          ),
        ),
      ),
    );
  }
}
