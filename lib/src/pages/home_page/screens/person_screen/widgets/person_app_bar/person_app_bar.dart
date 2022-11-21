import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/widgets/app_bar_space_with_exp_coll.dart';
import 'package:freader/src/pages/home_page/screens/person_screen/widgets/person_app_bar/person_app_bar_line.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class PersonAppBar extends StatelessWidget {
  final double appBarHeight;

  const PersonAppBar({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: appBarHeight,
        titleSpacing: 0,
        elevation: 0,
        floating: true,
        pinned: true,
        flexibleSpace: AppBarSpaceWithCollapsedAndExpandedParts(
          always: Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            top: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: doubleDefaultMargin, top: doubleDefaultMargin),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      settingsSvg,
                      color: Theme.of(context).paleElementColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          collapsed: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(
                left: doubleDefaultMargin, top: doubleDefaultMargin),
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Text(
                  "stats".toUpperCase(),
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
          ),
          expanded: SingleChildScrollView(
            child: SizedBox(
              height: appBarHeight,
              child: Container(
                  color: Theme.of(context).secondBackgroundColor,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          waveSvg,
                          fit: BoxFit.fill,
                          color: Theme.of(context).paleElementColor,
                        ),
                      ),
                      Observer(builder: (_) {
                        final db = context.read<DBController>();
                        final readingTime = db.books
                                .map((element) => element.readingTimeInMinutes)
                                .reduce((t1, t2) => t1 + t2) /
                            60;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PersonAppBarLine(
                                "Records:",
                                db.records
                                    .where((element) => !element.known)
                                    .length
                                    .toString()),
                            PersonAppBarLine(
                                "Known words:",
                                db.records
                                    .where((element) => element.known)
                                    .length
                                    .toString()),
                            PersonAppBarLine("reading:",
                                "${readingTime.toStringAsFixed(1)}H"),
                            const PersonAppBarLine("training:", "0H"),
                            const PersonAppBarLine("current streak:", "2-days"),
                          ],
                        );
                      })
                    ],
                  )),
            ),
          ),
        ));
  }
}
