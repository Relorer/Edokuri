import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/app_bar_title.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

import 'stats_graph.dart';

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
              padding: const EdgeInsets.symmetric(vertical: defaultMargin),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: doubleDefaultMargin),
                    child: AppBarTitle(
                      leftText: LocaleKeys.today.tr(),
                      rightText: LocaleKeys.short_min
                          .tr(namedArgs: {"count": 47.toString()}),
                    ),
                  ),
                  const SizedBox(
                    height: doubleDefaultMargin,
                  ),
                  Expanded(
                    child: SizedBox.expand(
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: GraphWidget(),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
