import 'package:flutter/material.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/records_screen_records_cards.dart';
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
              child: Column(
                children: const [RecordsScreenRecordsCards()],
              )),
        ),
      ),
    );
  }
}
