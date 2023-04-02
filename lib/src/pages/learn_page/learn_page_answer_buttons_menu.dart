// 🐦 Flutter imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/pages/learn_page/learn_page_answer_button.dart';

class LearnPageAnswerButtonsMenu extends StatelessWidget {
  const LearnPageAnswerButtonsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final learnController = context.read<LearnController>();

    return Container(
      color: Theme.of(context).secondBackgroundColor,
      child: Row(
        children: [
          LearnPageAnswerButton(
            onTap: learnController.markRecordAgain,
            topText: learnController.againText,
            bottomText: "again",
            color: const Color(0xFFCE4003),
          ),
          LearnPageAnswerButton(
            onTap: learnController.markRecordHard,
            topText: learnController.hardText,
            bottomText: "hard",
            color: Colors.white,
          ),
          LearnPageAnswerButton(
            onTap: learnController.markRecordGood,
            topText: learnController.goodText,
            bottomText: "good",
            color: const Color(0xFF34A853),
          ),
          LearnPageAnswerButton(
            onTap: learnController.markRecordEasy,
            topText: learnController.easyText,
            bottomText: "easy",
            color: const Color(0xFF4285F4),
          ),
        ],
      ),
    );
  }
}
