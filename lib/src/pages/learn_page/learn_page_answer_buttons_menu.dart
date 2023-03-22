// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/pages/learn_page/learn_page_answer_button.dart';

class LearnPageAnswerButtonsMenu extends StatelessWidget {
  final void Function()? changeIsShown;
  final void Function()? markRecordEasy;
  final void Function()? markRecordGood;
  final void Function()? markRecordHard;
  final void Function()? markRecordAgain;

  const LearnPageAnswerButtonsMenu(
      {super.key,
      required this.changeIsShown,
      required this.markRecordEasy,
      required this.markRecordGood,
      required this.markRecordHard,
      required this.markRecordAgain});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LearnPageAnswerButton(
          onTap: () => {changeIsShown!(), markRecordAgain!()},
          topText: "< 1 min",
          bottomText: "again",
          color: const Color(0xFFCE4003),
        ),
        LearnPageAnswerButton(
          onTap: () => {
            changeIsShown!(),
            markRecordHard!(),
          },
          topText: "< 10 min",
          bottomText: "hard",
          color: Colors.white,
        ),
        LearnPageAnswerButton(
          onTap: () => {
            changeIsShown!(),
            markRecordGood!(),
          },
          topText: "1d",
          bottomText: "good",
          color: const Color(0xFF34A853),
        ),
        LearnPageAnswerButton(
          onTap: () => {
            changeIsShown!(),
            markRecordEasy!(),
          },
          topText: "4d",
          bottomText: "easy",
          color: const Color(0xFF4285F4),
        ),
      ],
    );
  }
}
