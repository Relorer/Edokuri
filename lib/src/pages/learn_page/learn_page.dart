// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_examples_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_header.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_meanings_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_sentences_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_synonyms_section.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_translations_section.dart';
import 'package:edokuri/src/core/widgets/safe_area_with_settings.dart';
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

class LearnPageState extends State<LearnPage> with WidgetsBindingObserver {
  late LearningTimerController timer = getIt<LearningTimerController>();
  late LearnController learnController =
      getIt<LearnController>(param1: widget.records);

  @override
  initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    timer.startLearningTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        timer.stopLearningTimer();
        break;
      case AppLifecycleState.resumed:
        timer.startLearningTimer();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    timer.stopLearningTimer();
    super.dispose();
  }

  List<Widget> _getSections(Record record, bool isAnswerShown) {
    final sections = <Widget>[
      RecordInfoHeader(record.original, record.transcription),
    ];

    if (isAnswerShown) {
      sections.add(RecordInfoTranslationsSection(
        changeable: false,
        translations:
            record.translations.where((element) => element.selected).toList(),
      ));
    }

    if (isAnswerShown && record.synonyms.isNotEmpty) {
      sections.add(RecordInfoSynonymsSection(
        synonyms: record.synonyms,
        openCard: false,
      ));
    }

    if (record.sentences.isNotEmpty) {
      sections.add(RecordInfoSentencesSection(
        key: ValueKey(record.id + isAnswerShown.toString()),
        sentences: record.sentences,
        showTranslation: isAnswerShown,
        openCard: false,
      ));
    }
    if (record.examples.isNotEmpty) {
      sections.add(RecordInfoExamplesSection(
        key: ValueKey("${record.id}${isAnswerShown}example"),
        examples: record.examples,
        showTranslation: isAnswerShown,
        openCard: false,
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
            Observer(builder: (context) {
              return learnController.canRevertLastMark
                  ? IconButton(
                      icon: SvgPicture.asset(
                        backArrowSvg,
                      ),
                      onPressed: learnController.revertLastMark,
                    )
                  : const SizedBox();
            })
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          color: Theme.of(context).secondBackgroundColor,
          child: Observer(builder: (context) {
            return SafeAreaWithSettings(
              child: Container(
                  color: white,
                  child: learnController.currentRecord == null
                      ? const Center(
                          child: Text(
                          "There are no records to review \nCome back later",
                          textAlign: TextAlign.center,
                        ))
                      : Column(
                          children: [
                            const LearnPageHeader(),
                            Expanded(
                              child: BouncingCustomScrollView(slivers: [
                                SliverSingleChild(Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          doubleDefaultMargin),
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
                        )),
            );
          }),
        ),
      ),
    );
  }
}
