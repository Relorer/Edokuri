// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
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
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class AddRecordPage extends StatefulWidget {
  final SetRecords? set;
  const AddRecordPage({Key? key, required this.set}) : super(key: key);

  @override
  AddRecordPageState createState() {
    return AddRecordPageState();
  }
}

class AddRecordPageState extends State<AddRecordPage> {
  late RecordRepository _recordRepository;
  late TextEditingController _phraseController;
  late TranslatorController _translator;

  Record? _record;
  bool _isLoading = false;

  @override
  void initState() {
    _recordRepository = getIt<RecordRepository>();
    _phraseController = TextEditingController();
    _translator = getIt<TranslatorController>();
    super.initState();
  }

  void _phraseTextSubmitted(String text) async {
    _phraseController.clear();
    _saveCurrentRecord();
    setState(() {
      _isLoading = true;
      _record = null;
    });
    final temp = _recordRepository.getRecord(text);
    _record = temp != null && temp.translations.isNotEmpty
        ? temp
        : await _translator.translate(text);
    _isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _saveCurrentRecord();
    super.dispose();
  }

  _saveCurrentRecord() {
    if (_record == null) return;
    if (_record!.translations.any((element) => element.selected)) {
      _record!.translations.removeWhere(
          (element) => element.source == userSource && !element.selected);
      _recordRepository.putRecord(_record!, set: widget.set);
    } else if (_record!.id.isNotEmpty) {
      _recordRepository.removeRecord(_record!, set: widget.set);
    }
  }

  List<Widget> _getSections(Record record) {
    final sections = [
      RecordInfoHeader(record.original, record.transcription),
      RecordInfoTranslationsSection(
        translations: record.translations,
      )
    ];

    if (record.synonyms.isNotEmpty) {
      sections.add(RecordInfoSynonymsSection(
        synonyms: record.synonyms,
        openCard: false,
      ));
    }
    if (record.sentences.isNotEmpty) {
      sections.add(RecordInfoSentencesSection(
        key: ValueKey(record.id),
        sentences: record.sentences,
        showTranslation: true,
        openCard: false,
      ));
    }
    if (record.examples.isNotEmpty) {
      sections.add(RecordInfoExamplesSection(
        key: ValueKey("${record.id}example"),
        examples: record.examples,
        showTranslation: true,
        openCard: false,
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
    return Container(
      color: Theme.of(context).secondBackgroundColor,
      child: SafeAreaWithSettings(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).secondBackgroundColor,
            elevation: 0,
            title: Text("Add to ${widget.set?.name ?? "All"}"),
          ),
          backgroundColor: _record == null
              ? Theme.of(context).colorScheme.background
              : Colors.white,
          body: SafeAreaWithSettings(
              child: Column(
            children: [
              Visibility(
                  replacement: const SizedBox(height: 3),
                  visible: _isLoading,
                  child: const LinearProgressIndicator(
                    minHeight: 3,
                    color: lightGray,
                  )),
              Expanded(
                child: BouncingCustomScrollView(
                  slivers: [
                    SliverSingleChild(Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: doubleDefaultMargin),
                      child: Column(
                        children: [
                          TextFormFieldDefault(
                            controller: _phraseController,
                            labelText: 'Enter a phrase',
                            onFieldSubmitted: _phraseTextSubmitted,
                          ),
                          const SizedBox(
                            height: doubleDefaultMargin,
                          ),
                          _record == null
                              ? Container()
                              : Wrap(
                                  runSpacing: defaultMargin,
                                  children: _getSections(_record!),
                                ),
                          const SizedBox(
                            height: doubleDefaultMargin,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
