import 'package:flutter/cupertino.dart';
import 'package:freader/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_section_header.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoExamplesSection extends StatelessWidget {
  final List<Example> examples;
  final bool showTranslation;

  const RecordInfoExamplesSection(
      {super.key, required this.examples, this.showTranslation = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RecordInfoSectionHeader("Usage examples"),
        ...examples.map((element) => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    width: double.maxFinite,
                    child: Text(element.text,
                        style: const TextStyle(
                          fontSize: 14,
                        ))),
                showTranslation
                    ? SizedBox(
                        width: double.maxFinite,
                        child: Text(element.tr,
                            style: const TextStyle(
                                fontSize: 14, color: paleElement)))
                    : Container(),
                SizedBox(
                  height: examples.indexOf(element) == examples.length - 1
                      ? 0
                      : defaultMargin,
                )
              ],
            )),
      ],
    );
  }
}
