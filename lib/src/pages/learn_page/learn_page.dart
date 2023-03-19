// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_examples_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_header.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_meanings_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_sentences_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_synonyms_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_translations_section.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/learn_page/learn_page_answer_buttons_menu.dart';
import 'package:edokuri/src/pages/learn_page/learn_page_header.dart';
import 'package:edokuri/src/pages/learn_page/learn_page_show_answer_button.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LearnPage extends StatefulWidget {
  final SetData setData;
  final List<Record> records;
  const LearnPage({Key? key, required this.records, required this.setData})
      : super(key: key);

  @override
  LearnPageState createState() {
    return LearnPageState();
  }
}

class LearnPageState extends State<LearnPage> {
  bool answerIsShown = false;

  List<Widget> _getSections(Record record) {
    final sections = <Widget>[
      RecordInfoHeader(record.original),
    ];

    if (answerIsShown) {
      sections.add(RecordInfoTranslationsSection(
        changeable: false,
        translations:
            record.translations.where((element) => element.selected).toList(),
      ));
    }

    if (record.examples.isNotEmpty) {
      sections.add(RecordInfoExamplesSection(
        examples: record.examples,
        showTranslation: answerIsShown,
      ));
    }
    if (answerIsShown && record.synonyms.isNotEmpty) {
      sections.add(RecordInfoSynonymsSection(synonyms: record.synonyms));
    }
    if (record.sentences.isNotEmpty) {
      sections.add(RecordInfoSentencesSection(
        sentences: record.sentences,
        showTranslation: answerIsShown,
      ));
    }
    if (answerIsShown && record.meanings.isNotEmpty) {
      sections.add(RecordInfoMeaningsSection(
        meanings: record.meanings,
      ));
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondBackgroundColor,
        elevation: 0,
        title: Text(widget.setData.set?.name ?? "All"),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              backArrowSvg,
            ),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
        children: [
          const LearnPageHeader(
            newRecords: 20,
            reviewedRecords: 128,
            studiedRecords: 10,
          ),
          Expanded(
            child: BouncingCustomScrollView(slivers: [
              SliverSingleChild(Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(doubleDefaultMargin),
                    child: Wrap(
                      runSpacing: defaultMargin,
                      children: _getSections(widget.records.first),
                    ),
                  )
                ],
              ))
            ]),
          ),
          answerIsShown
              ? const LearnPageAnswerButtonsMenu()
              : LearnPageShowAnswerButton(
                  onTap: () {
                    setState(() {
                      answerIsShown = true;
                    });
                  },
                )
        ],
      )),
    );
  }
}
