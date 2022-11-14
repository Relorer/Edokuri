import 'package:flutter/material.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_examples_section.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_header.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_meanings_section.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_synonyms_section.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_translations_section.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:textfield_tags/textfield_tags.dart';

class RecordInfoCard extends StatefulWidget {
  final Record record;
  final ScrollController scrollController;

  const RecordInfoCard(
      {super.key, required this.record, required this.scrollController});

  @override
  State<RecordInfoCard> createState() => RecordInfoCardState();
}

class RecordInfoCardState extends State<RecordInfoCard> {
  late TextfieldTagsController _controller;

  @override
  initState() {
    _controller = TextfieldTagsController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;

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
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
          child: Wrap(
            runSpacing: defaultMargin,
            children: [
              RecordInfoHeader(record.original),
              RecordInfoTranslationsSection(
                translations: record.translations,
              ),
              record.examples.isNotEmpty
                  ? RecordInfoExamplesSection(examples: record.examples)
                  : Container(),
              record.synonyms.isNotEmpty
                  ? RecordInfoSynonymsSection(synonyms: record.synonyms)
                  : Container(),
              record.meanings.isNotEmpty
                  ? RecordInfoMeaningsSection(
                      meanings: record.meanings,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
