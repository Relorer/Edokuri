import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/app_bar_title.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class RecordsAppBar extends StatelessWidget {
  final double appBarHeight;

  const RecordsAppBar({super.key, required this.appBarHeight});

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
                      return AppBarTitle(
                        leftText: LocaleKeys.today.tr(),
                        rightText: LocaleKeys.short_min.tr(namedArgs: {
                          "count": (context
                                  .read<DBController>()
                                  .readingTimeForTodayInMinutes)
                              .toString()
                        }),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: doubleDefaultMargin,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
