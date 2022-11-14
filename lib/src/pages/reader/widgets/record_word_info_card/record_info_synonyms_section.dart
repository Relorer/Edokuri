import 'package:flutter/material.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_section_header.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoSynonymsSection extends StatelessWidget {
  final List<String> synonyms;

  const RecordInfoSynonymsSection({super.key, required this.synonyms});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RecordInfoSectionHeader("Synonyms"),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: defaultMargin / 2,
          runSpacing: defaultMargin / 2,
          children: List<Widget>.generate(
            synonyms.length,
            (int index) {
              return Chip(
                backgroundColor:
                    Theme.of(context).paleElementColor.withOpacity(0.1),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0),
                visualDensity:
                    const VisualDensity(horizontal: 0.0, vertical: -4),
                label: Text(synonyms[index].toLowerCase()),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
