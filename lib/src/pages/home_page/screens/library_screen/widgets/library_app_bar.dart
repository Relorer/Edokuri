import 'package:flutter/material.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/title_widget.dart';
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
              padding: const EdgeInsets.symmetric(
                  vertical: defaultMargin, horizontal: doubleDefaultMargin),
              child: Column(
                children: const [
                  TitleWidget(
                    leftText: "today",
                    rightText: "47m",
                  ),
                  SizedBox(
                    height: doubleDefaultMargin,
                  ),
                  GraphWidget(),
                ],
              )),
        ),
      ),
    );
  }
}
