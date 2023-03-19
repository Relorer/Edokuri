// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/pages/learn_page/learn_page_answer_button.dart';

class LearnPageAnswerButtonsMenu extends StatelessWidget {
  const LearnPageAnswerButtonsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LearnPageAnswerButton(
          onTap: () => {},
          topText: "< 1 min",
          bottomText: "again",
          color: const Color(0xFFCE4003),
        ),
        LearnPageAnswerButton(
          onTap: () => {},
          topText: "< 10 min",
          bottomText: "hard",
          color: Colors.white,
        ),
        LearnPageAnswerButton(
          onTap: () => {},
          topText: "1d",
          bottomText: "good",
          color: const Color(0xFF34A853),
        ),
        LearnPageAnswerButton(
          onTap: () => {},
          topText: "4d",
          bottomText: "easy",
          color: const Color(0xFF4285F4),
        ),
      ],
    );
  }
}
