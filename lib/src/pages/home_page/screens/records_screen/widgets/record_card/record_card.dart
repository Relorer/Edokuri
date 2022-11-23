import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:text_to_speech/text_to_speech.dart';

class RecordCard extends StatelessWidget {
  final Record record;

  const RecordCard(this.record, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: (() {
        TextToSpeech tts = TextToSpeech();
        tts.speak(record.original);
      }),
      child: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: AutoSizeText(
          record.transcription,
          maxLines: 5,
        ),
      ),
    );
  }
}
