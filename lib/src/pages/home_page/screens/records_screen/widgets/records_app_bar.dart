import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

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
      pinned: false,
      flexibleSpace: SingleChildScrollView(
        child: SizedBox(
          height: appBarHeight,
          child: Container(
              color: Theme.of(context).secondBackgroundColor,
              padding:
                  const EdgeInsets.symmetric(vertical: doubleDefaultMargin),
              child: Column(
                children: [],
              )),
        ),
      ),
    );
  }
}
