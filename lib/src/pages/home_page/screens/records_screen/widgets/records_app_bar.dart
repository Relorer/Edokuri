import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/app_bar_space_with_exp_coll.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/records_screen_records_cards.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordsAppBar extends StatelessWidget {
  final double appBarHeight;
  final VoidCallback? resetScrollClick;

  const RecordsAppBar(
      {super.key, required this.appBarHeight, this.resetScrollClick});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: appBarHeight,
        titleSpacing: 0,
        elevation: 0,
        floating: false,
        pinned: true,
        snap: false,
        flexibleSpace: AppBarSpaceWithCollapsedAndExpandedParts(
          collapsed: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: doubleDefaultMargin,
                  top: doubleDefaultMargin,
                  left: doubleDefaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Records".toUpperCase(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: white,
                      ),
                      onPressed: resetScrollClick,
                    ),
                  )
                ],
              ),
            ),
          ),
          expanded: SingleChildScrollView(
            child: SizedBox(
              height: appBarHeight,
              child: Container(
                  color: Theme.of(context).secondBackgroundColor,
                  child: Column(
                    children: const [RecordsScreenRecordsCards()],
                  )),
            ),
          ),
        ));
  }
}
