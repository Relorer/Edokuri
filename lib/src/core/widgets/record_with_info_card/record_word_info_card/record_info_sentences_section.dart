// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_section_header.dart';
import 'package:edokuri/src/core/widgets/translated_by.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

// 📦 Package imports:

class RecordInfoSentencesSection extends StatefulWidget {
  final bool showTranslation;
  final List<Example> sentences;

  const RecordInfoSentencesSection(
      {super.key, required this.sentences, required this.showTranslation});

  @override
  State<RecordInfoSentencesSection> createState() =>
      _RecordInfoSentencesSectionState();
}

class _RecordInfoSentencesSectionState
    extends State<RecordInfoSentencesSection> {
  late bool _showTranslation;

  @override
  void initState() {
    _showTranslation = widget.showTranslation;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RecordInfoSectionHeader("Sentences"),
        ...widget.sentences.map((element) => GestureDetector(
              onTap: () {
                getIt<TTSController>().speak(element.text);
              },
              onLongPress: () {
                setState(() {
                  _showTranslation = !_showTranslation;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      width: double.maxFinite,
                      child: Text(element.text,
                          style: const TextStyle(
                            fontSize: 14,
                          ))),
                  _showTranslation
                      ? Column(
                          children: [
                            SizedBox(
                                width: double.maxFinite,
                                child: Text(element.tr,
                                    style: const TextStyle(
                                        fontSize: 14, color: lightGray))),
                            SizedBox(
                              height: widget.sentences.indexOf(element) ==
                                      widget.sentences.length - 1
                                  ? 0
                                  : defaultMargin,
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            )),
        _showTranslation
            ? TranslatedBy(source: widget.sentences.first.source)
            : Container()
      ],
    );
  }
}
