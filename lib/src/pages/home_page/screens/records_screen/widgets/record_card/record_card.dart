import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:text_to_speech/text_to_speech.dart';

class RecordCard extends StatelessWidget {
  final Record record;

  const RecordCard(this.record, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: (() {}),
      child: Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AutoSizeText(
                      record.original,
                      maxLines: 5,
                      style: Theme.of(context).cardTitleStyle,
                    ),
                    AutoSizeText(
                      record.translation,
                      maxLines: 5,
                      style: Theme.of(context).cardSubtitleStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () =>
                      getIt<TTSController>().speak(record.original),
                  icon: SvgPicture.asset(
                    speakerSvg,
                    color: Theme.of(context).paleElementColor,
                  )),
            ],
          )),
    );
  }
}
