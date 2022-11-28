import 'package:flutter/material.dart';
import 'package:freader/src/controllers/common/translator_controller/translate_source.dart';
import 'package:freader/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/core/widgets/provider_sliding_up_panel.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_card_container.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_card_content.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_card_skeleton.dart';
import 'package:freader/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecordWithInfoCard extends StatefulWidget {
  final bool showTranslationSourceSentences;
  final double bottomPadding;
  final Widget body;
  final SetRecords? set;

  const RecordWithInfoCard(
      {super.key,
      required this.body,
      this.bottomPadding = 55,
      this.set,
      this.showTranslationSourceSentences = true});

  @override
  State<RecordWithInfoCard> createState() => _RecordWithInfoCardState();
}

class _RecordWithInfoCardState extends State<RecordWithInfoCard> {
  late RecordRepository _recordRepository;
  late TranslatorController _translator;

  Record? _record;
  final PanelController _panelController = PanelController();
  bool _blockBody = false;

  @override
  initState() {
    super.initState();
    _recordRepository = context.read<RecordRepository>();
    _translator = getIt<TranslatorController>();
  }

  _tapOnWordHandler(String word, String sentence) async {
    if (word.isEmpty) return;

    await _panelController.close().then((value) => setState(() {
          FocusScope.of(context).unfocus();
          _blockBody = true;
        }));

    final getting = Future.delayed(
        Duration(milliseconds: _panelController.isPanelClosed ? 0 : 200),
        (() async {
      final temp = _recordRepository.getRecord(word);
      _record = temp != null && temp.translations.isNotEmpty
          ? temp
          : await _translator.translate(word);

      if (_record != null &&
          sentence.isNotEmpty &&
          _record!.sentences
              .where((element) =>
                  element.text.toLowerCase().trim() ==
                  sentence.toLowerCase().trim())
              .isEmpty) {
        _record!.sentences.add(
            Example(sentence, await _translator.translateSentence(sentence)));
      }
    }));

    await Future.delayed(const Duration(milliseconds: 300));

    if (_record != null) {
      setState(() {});
      _panelController.open();
    } else {
      _panelController.open();
      await getting;
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {});
    }
  }

  _saveCurrentRecord() {
    if (_record == null) return;
    if (_record!.translations.any((element) => element.selected)) {
      _record!.translations.removeWhere(
          (element) => element.source == userSource && !element.selected);
      _record!.known = false;
      _recordRepository.putRecord(_record!, set: widget.set);
    } else if (!_record!.known && _record!.id > 0) {
      _recordRepository.removeRecord(_record!, set: widget.set);
    }
  }

  _panelCloseHandler() {
    _saveCurrentRecord();
    setState(() {
      _record = null;
      _blockBody = false;
    });
  }

  @override
  void dispose() {
    _saveCurrentRecord();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TapOnWordHandlerProvider(
          tapOnWordHandler: _tapOnWordHandler,
          child: ProviderSlidingUpPanel(
            controller: _panelController,
            panelCloseHandler: _panelCloseHandler,
            blockBody: _blockBody,
            body: widget.body,
            panelBuilder: (ScrollController sc) => Padding(
              padding: EdgeInsets.only(bottom: widget.bottomPadding),
              child: RecordInfoCardContainer(
                  scrollController: sc,
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.easeInCubic,
                    switchOutCurve: Curves.easeOutCubic,
                    duration: const Duration(milliseconds: 200),
                    child: _record == null
                        ? const RecordInfoCardSkeleton()
                        : RecordInfoCardContent(
                            record: _record!,
                            showTranslationSourceSentences:
                                widget.showTranslationSourceSentences,
                          ),
                  )),
            ),
          )),
    );
  }
}
