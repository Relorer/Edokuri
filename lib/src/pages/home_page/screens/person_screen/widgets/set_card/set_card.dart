import 'package:flutter/material.dart';
import 'package:freader/src/core/utils/records_list_extensions.dart';
import 'package:freader/src/core/widgets/ellipsis_text.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/models/set.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class SetCard extends StatelessWidget {
  final SetRecords set;

  const SetCard(
    this.set, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EllipsisText(
                set.name,
                style: Theme.of(context).bookTitleStyle,
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              EllipsisText(
                "${set.records.saved.length} records",
                style: Theme.of(context).cardSubtitleStyle,
              ),
            ],
          )),
    );
  }
}
