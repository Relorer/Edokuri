import 'package:flutter/material.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:freader/src/core/widgets/default_card_container.dart';
import 'package:freader/src/pages/learn_page/learn_card_content.dart';
import 'package:freader/src/pages/learn_page/learn_swipable_stack.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

class LearnPageCardStack extends StatelessWidget {
  const LearnPageCardStack({super.key});

  @override
  Widget build(BuildContext context) {
    final learnController = context.read<LearnController>();

    return LearnSwipableStack(
      onSwipeCompleted: (index, direction) {
        final learn = context.read<LearnController>();
        learn.answerHandler(index, direction == SwipeDirection.right);
        if (learn.autoPronouncing) {
          getIt<TTSController>()
              .speak(learn.getRecordByIndex(index + 1).original);
        }
        learn.setCurrentRecord(learn.getRecordByIndex(index + 1));
      },
      builder: (context, properties) => LearnCardContent(
        record: learnController.getRecordByIndex(properties.index),
      ),
      right: const DefaultCardContainer(
        Center(
            child: Text(
          "Know",
          style: TextStyle(
              fontSize: 32,
              color: Color(0xff14B220),
              fontWeight: FontWeight.bold),
        )),
      ),
      left: const DefaultCardContainer(
        Center(
            child: Text(
          "Still learning",
          style: TextStyle(
              fontSize: 32, color: savedWord, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
