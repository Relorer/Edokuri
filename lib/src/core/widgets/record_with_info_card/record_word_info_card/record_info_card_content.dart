// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_examples_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_header.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_meanings_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_sentences_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_synonyms_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_translations_section.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordInfoCardContent extends StatelessWidget {
  final bool showTranslationSourceSentences;
  final Record record;

  const RecordInfoCardContent(
      {super.key,
      required this.record,
      required this.showTranslationSourceSentences});

  List<Widget> _getSections(Record record) {
    final sections = [
      RecordInfoHeader(record.original),
      RecordInfoTranslationsSection(
        translations: record.translations,
      )
    ];

    if (record.examples.isNotEmpty) {
      sections.add(RecordInfoExamplesSection(examples: record.examples));
    }
    if (record.synonyms.isNotEmpty) {
      sections.add(RecordInfoSynonymsSection(synonyms: record.synonyms));
    }
    if (record.sentences.isNotEmpty) {
      sections.add(RecordInfoSentencesSection(
        sentences: record.sentences,
        showTranslation: showTranslationSourceSentences,
      ));
    }
    if (record.meanings.isNotEmpty) {
      sections.add(RecordInfoMeaningsSection(
        meanings: record.meanings,
      ));
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: defaultMargin,
      children: _getSections(record),
    );
  }
}
