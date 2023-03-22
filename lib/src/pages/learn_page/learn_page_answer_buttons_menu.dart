// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/pages/learn_page/learn_page_answer_button.dart';

class LearnPageAnswerButtonsMenu extends StatelessWidget {
  final LearnController learnController;

  const LearnPageAnswerButtonsMenu({super.key, required this.learnController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LearnPageAnswerButton(
          onTap: () => {
            learnController.markRecordAgain(),
            learnController.answerIsShown = false
          },
          topText: "< 1 min",
          bottomText: "again",
          color: const Color(0xFFCE4003),
        ),
        LearnPageAnswerButton(
          onTap: () => {
            learnController.markRecordHard(),
            learnController.answerIsShown = false
          },
          topText: "< 10 min",
          bottomText: "hard",
          color: Colors.white,
        ),
        LearnPageAnswerButton(
          onTap: () => {
            learnController.markRecordGood(),
            learnController.answerIsShown = false
          },
          topText: "1d",
          bottomText: "good",
          color: const Color(0xFF34A853),
        ),
        LearnPageAnswerButton(
          onTap: () => {
            learnController.markRecordEasy(),
            learnController.answerIsShown = false
          },
          topText: "4d",
          bottomText: "easy",
          color: const Color(0xFF4285F4),
        ),
      ],
    );
  }
}
