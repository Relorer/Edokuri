import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_meanings_section.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_synonyms_section.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_translations_section.dart';
import 'package:freader/src/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_examples_section.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_sentences_section.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LearnCardFull extends StatelessWidget {
  final Record record;

  const LearnCardFull({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        onTap: () => getIt<TTSController>().speak(record.original),
        child: Column(children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(doubleDefaultMargin),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AutoSizeText(
                      record.original,
                      maxLines: record.original.contains(" ") ? null : 1,
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
                    SizedBox(
                      height: defaultMargin,
                    ),
                    RecordInfoTranslationsSection(
                      translations: record.translations,
                      changeable: false,
                    ),
                    record.examples.isNotEmpty || record.sentences.isNotEmpty
                        ? const SizedBox(
                            height: doubleDefaultMargin,
                          )
                        : Container(),
                    record.synonyms.isNotEmpty
                        ? RecordInfoSynonymsSection(
                            synonyms: record.synonyms,
                            pressable: false,
                          )
                        : Container(),
                    record.examples.isNotEmpty
                        ? RecordInfoExamplesSection(
                            examples: record.examples,
                            showTranslation: true,
                          )
                        : Container(),
                    record.sentences.isNotEmpty
                        ? RecordInfoSentencesSection(
                            sentences: record.sentences,
                            showTranslation: true,
                          )
                        : Container(),
                    record.meanings.isNotEmpty
                        ? RecordInfoMeaningsSection(
                            meanings: record.meanings,
                          )
                        : Container(),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
