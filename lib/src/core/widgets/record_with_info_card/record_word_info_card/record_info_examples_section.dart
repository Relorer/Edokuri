import 'package:flutter/cupertino.dart';
import 'package:freader/src/models/record.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_section_header.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoExamplesSection extends StatelessWidget {
  final List<Example> examples;

  const RecordInfoExamplesSection({super.key, required this.examples});

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
                SizedBox(
                    width: double.maxFinite,
                    child: Text(element.tr,
                        style:
                            const TextStyle(fontSize: 14, color: paleElement))),
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
