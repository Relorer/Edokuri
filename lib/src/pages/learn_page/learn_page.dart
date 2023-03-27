// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
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
  late LearnController learnController =
      getIt<LearnController>(param1: widget.records);

  List<Widget> _getSections(Record record, bool isAnswerShown) {
    final sections = <Widget>[
      RecordInfoHeader(record.original),
    ];

    if (isAnswerShown) {
      sections.add(RecordInfoTranslationsSection(
        changeable: false,
        translations:
            record.translations.where((element) => element.selected).toList(),
      ));
    }

    if (record.examples.isNotEmpty) {
      sections.add(RecordInfoExamplesSection(
        examples: record.examples,
        showTranslation: isAnswerShown,
      ));
    }

    if (isAnswerShown && record.synonyms.isNotEmpty) {
      sections.add(RecordInfoSynonymsSection(synonyms: record.synonyms));
    }

    if (record.sentences.isNotEmpty) {
      sections.add(RecordInfoSentencesSection(
        sentences: record.sentences,
        showTranslation: isAnswerShown,
      ));
    }

    if (isAnswerShown && record.meanings.isNotEmpty) {
      sections.add(RecordInfoMeaningsSection(
        meanings: record.meanings,
      ));
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LearnController>(create: (_) => learnController),
      ],
      child: Scaffold(
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
        body: Observer(builder: (context) {
          return SafeArea(
              child: learnController.currentRecord == null
                  ? const Center(
                      child: Text(
                      "There are no records to review \nCome back later",
                      textAlign: TextAlign.center,
                    ))
                  : Column(
                      children: [
                        LearnPageHeader(
                          newRecords: learnController.recent.length,
                          reviewedRecords: learnController.repeatable.length,
                          studiedRecords: learnController.studied.length,
                        ),
                        Expanded(
                          child: BouncingCustomScrollView(slivers: [
                            SliverSingleChild(Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.all(doubleDefaultMargin),
                                  child: Wrap(
                                    runSpacing: defaultMargin,
                                    children: _getSections(
                                        learnController.currentRecord!,
                                        learnController.answerIsShown),
                                  ),
                                )
                              ],
                            ))
                          ]),
                        ),
                        learnController.answerIsShown
                            ? const LearnPageAnswerButtonsMenu()
                            : LearnPageShowAnswerButton(onTap: () {
                                setState(() {
                                  learnController.answerIsShown = true;
                                });
                              }),
                      ],
                    ));
        }),
      ),
    );
  }
}
