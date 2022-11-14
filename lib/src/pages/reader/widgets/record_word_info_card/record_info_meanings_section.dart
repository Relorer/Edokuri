import 'package:freader/src/core/utils/iterable_extensions.dart';
import 'package:freader/src/models/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/pages/reader/widgets/record_word_info_card/record_info_section_header.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoMeaningsSection extends StatelessWidget {
  final List<Meaning> meanings;

  const RecordInfoMeaningsSection({super.key, required this.meanings});

  @override
  Widget build(BuildContext context) {
    final groupedMeanings = meanings.groupBy(
      (p0) => p0.pos,
    );

    final List<Widget> meaningsWidgets = [];

    for (var key in groupedMeanings.keys) {
      final mForKey = groupedMeanings[key] ?? [];
      meaningsWidgets.add(SizedBox(
          width: double.maxFinite,
          child: Text(key,
              style: const TextStyle(
                fontSize: 14,
              ))));
      for (Meaning m in mForKey) {
        meaningsWidgets.add(const SizedBox(
          height: 6,
        ));
        meaningsWidgets.add(SizedBox(
            width: double.maxFinite,
            child: Text(m.description,
                style: const TextStyle(fontSize: 14, color: paleElement))));
      }
      meaningsWidgets.add(SizedBox(
        height: groupedMeanings.keys.last == key ? 0 : defaultMargin,
      ));
    }

    return Column(
      children: [const RecordInfoSectionHeader("Meanings"), ...meaningsWidgets],
    );
  }
}
