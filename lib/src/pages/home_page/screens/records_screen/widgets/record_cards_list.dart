import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/controllers/records_sort_controller/record_sort_controller.dart';
import 'package:freader/src/core/utils/records_list_extensions.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/record_card/record_card.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class RecordCardsList extends StatelessWidget {
  const RecordCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<DBController>();

    return Observer(builder: (_) {
      final records =
          context.read<RecordsSortController>().sort(db.records.saved);

      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, defaultMargin),
                  child: RecordCard(records[index]),
                ),
            childCount: records.length),
      );
    });
  }
}
