import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/default_card_container.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LearnCardContent extends StatelessWidget {
  final Record record;

  const LearnCardContent({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(doubleDefaultMargin),
      child: DefaultCardContainer(
        GestureDetector(
          onTap: () => getIt<TTSController>().speak(record.original),
          child: Material(
            color: Colors.transparent,
            child: Column(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(doubleDefaultMargin),
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      AutoSizeText(
                        record.original,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      record.transcription.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: AutoSizeText(
                                record.transcription,
                                style: const TextStyle(
                                    fontSize: 18, color: paleElement),
                              ),
                            ),
                    ]),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.keyboard),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: doubleDefaultMargin,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
