// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_word_info_card/record_info_section_header.dart';
import 'package:edokuri/src/core/widgets/translated_by.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordInfoExamplesSection extends StatefulWidget {
  final List<Example> examples;
  final bool showTranslation;

  const RecordInfoExamplesSection(
      {super.key, required this.examples, this.showTranslation = true});

  @override
  State<RecordInfoExamplesSection> createState() =>
      _RecordInfoExamplesSectionState();
}

class _RecordInfoExamplesSectionState extends State<RecordInfoExamplesSection> {
  bool _showTranslation = false;

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
        const RecordInfoSectionHeader("Usage examples"),
        ...widget.examples.map((element) => GestureDetector(
              onDoubleTap: (() => TapOnWordHandlerProvider.of(context)
                  .tapOnWordHandler(element.text, "")),
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
                      ? SizedBox(
                          width: double.maxFinite,
                          child: Text(element.tr,
                              style: const TextStyle(
                                  fontSize: 14, color: lightGray)))
                      : Container(),
                  SizedBox(
                    height: widget.examples.indexOf(element) ==
                            widget.examples.length - 1
                        ? 0
                        : defaultMargin,
                  )
                ],
              ),
            )),
        _showTranslation
            ? TranslatedBy(source: widget.examples.first.source)
            : Container()
      ],
    );
  }
}
