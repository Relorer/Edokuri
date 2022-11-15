import 'package:flutter/material.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_examples_section.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_header.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_meanings_section.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_synonyms_section.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_translations_section.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoCard extends StatelessWidget {
  final Record record;
  final ScrollController scrollController;

  const RecordInfoCard(
      {super.key, required this.record, required this.scrollController});

  @override
  Widget build(BuildContext context) {
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
    if (record.meanings.isNotEmpty) {
      sections.add(RecordInfoMeaningsSection(
        meanings: record.meanings,
      ));
    }

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: doubleDefaultMargin * 2, horizontal: doubleDefaultMargin),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
          boxShadow: [
            BoxShadow(
              blurRadius: defaultMargin,
              color: Theme.of(context).paleElementColor.withOpacity(0.2),
            ),
          ]),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
          child: Wrap(
            runSpacing: defaultMargin,
            children: sections,
          ),
        ),
      ),
    );
  }
}
