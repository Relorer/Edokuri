import 'package:flutter/widgets.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/set_page/widgets/record_card/record_card.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordCardsList extends StatelessWidget {
  final List<Record> records;

  const RecordCardsList(this.records, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultMargin, 0, defaultMargin, defaultMargin),
                child: RecordCard(records[index]),
              ),
          childCount: records.length),
    );
  }
}
