import 'package:flutter/material.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/title_widget.dart';
import 'package:freader/src/theme/theme.dart';

import 'stats_graph.dart';

class LibraryAppBar extends StatelessWidget {
  final double appBarHeight;

  const LibraryAppBar({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      expandedHeight: appBarHeight,
      floating: true,
      pinned: true,
      elevation: 0,
      flexibleSpace: SingleChildScrollView(
        child: SizedBox(
          height: appBarHeight,
          child: Container(
              color: Theme.of(context).secondBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: const [
                  TitleWidget(
                    leftText: "today",
                    rightText: "47m",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GraphWidget(),
                ],
              )),
        ),
      ),
    );
  }
}
