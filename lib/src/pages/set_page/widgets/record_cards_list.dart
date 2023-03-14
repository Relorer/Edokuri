// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/search_record_controller/search_record_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/set_page/widgets/record_card/record_card.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordCardsList extends StatelessWidget {
  final SetData setData;

  const RecordCardsList({super.key, required this.setData});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final sortedRecords =
          getIt<RecordsSortController>().sort(setData.records);
      final foundRecords =
          context.read<SearchRecordController>().getSearchResult(sortedRecords);
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, defaultMargin),
                  child: RecordCard(
                    foundRecords[index],
                    setData: setData,
                  ),
                ),
            childCount: foundRecords.length),
      );
    });
  }
}
