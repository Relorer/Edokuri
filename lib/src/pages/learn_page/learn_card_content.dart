import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/default_card_container.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/pages/learn_page/learn_card_definition.dart';
import 'package:freader/src/pages/learn_page/learn_card_full.dart';
import 'package:freader/src/pages/learn_page/learn_card_term.dart';
import 'package:freader/src/pages/learn_page/learn_card_type.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class LearnCardContent extends StatefulWidget {
  final Record record;

  const LearnCardContent({super.key, required this.record});

  @override
  State<LearnCardContent> createState() => _LearnCardContentState();
}

class _LearnCardContentState extends State<LearnCardContent> {
  Random random = Random();
  late LearnController learn = context.read<LearnController>();

  late int currentState = getStartState();

  late List<Widget> cardStates = [
    LearnCardDefinition(
      record: widget.record,
    ),
    LearnCardTerm(
      record: widget.record,
    ),
    LearnCardFull(
      record: widget.record,
    ),
    LearnCardType(record: widget.record),
  ];

  int getStartState() {
    int result = 0;
    if (learn.definitionOn && learn.termOn) {
      result = random.nextInt(2);
    } else if (learn.termOn) {
      result = 1;
    }
    if (result == 1) learn.needSpeak.add(widget.record);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(doubleDefaultMargin),
      child: DefaultCardContainer(cardStates[currentState]),
    );
  }
}
