import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/app_bar_title.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

import 'stats_graph/stats_graph.dart';

class LibraryAppBar extends StatelessWidget {
  final double appBarHeight;

  const LibraryAppBar({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: appBarHeight,
      titleSpacing: 0,
      elevation: 0,
      floating: true,
      pinned: true,
      flexibleSpace: SingleChildScrollView(
        child: SizedBox(
          height: appBarHeight,
          child: Container(
              color: Theme.of(context).secondBackgroundColor,
              padding:
                  const EdgeInsets.symmetric(vertical: doubleDefaultMargin),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: doubleDefaultMargin),
                    child: Observer(builder: (_) {
                      final today = DateTime.now();
                      final readingTimesForToday = context
                          .read<DBController>()
                          .books
                          .expand((element) => element.readTimes)
                          .where((element) => element.start.isSameDate(today))
                          .map((e) =>
                              e.end.millisecondsSinceEpoch -
                              e.start.millisecondsSinceEpoch);
                      final readingTimeForToday = readingTimesForToday.isEmpty
                          ? 0
                          : readingTimesForToday.reduce((t1, t2) => t1 + t2);
                      return AppBarTitle(
                        leftText: LocaleKeys.today.tr(),
                        rightText: LocaleKeys.short_min.tr(namedArgs: {
                          "count": (readingTimeForToday / 1000 ~/ 60).toString()
                        }),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: doubleDefaultMargin,
                  ),
                  const StatsGraph(),
                ],
              )),
        ),
      ),
    );
  }
}
