import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/set_controller/set_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:freader/src/pages/set_page/widgets/record_card/record_card.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class RecordCardsList extends StatelessWidget {
  const RecordCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final soretedRecords = context
          .read<RecordsSortController>()
          .sort(context.read<SetController>().records);
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, defaultMargin),
                  child: RecordCard(soretedRecords[index]),
                ),
            childCount: soretedRecords.length),
      );
    });
  }
}
