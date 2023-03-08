// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/app_bar_title.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';
import 'stats_graph/stats_graph.dart';

class LibraryAppBar extends StatelessWidget {
  final double appBarHeight;

  const LibraryAppBar({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).secondBackgroundColor,
      expandedHeight: appBarHeight,
      titleSpacing: 0,
      elevation: 0,
      floating: false,
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
                      return AppBarTitle(
                        leftText: LocaleKeys.today.tr(),
                        rightText: LocaleKeys.shortMin.tr(namedArgs: {
                          "count": (context
                                      .read<BookRepository>()
                                      .readingTimeForTodayInMinutes() +
                                  context
                                      .read<UserRepository>()
                                      .learningTimeForTodayInMinutes())
                              .toString()
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
