// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/app_bar_space_with_exp_coll.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/stats_chart_graph/stats_chart_graph.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/person_app_bar/person_app_bar_line.dart';
import 'package:edokuri/src/pages/settings_page/settings_page.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class PersonAppBar extends StatelessWidget {
  final double appBarHeight;

  const PersonAppBar({super.key, required this.appBarHeight});

  void _openSettings(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: appBarHeight,
        titleSpacing: 0,
        elevation: 0,
        floating: false,
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
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.srcIn),
                    ),
                    onPressed: () => _openSettings(context),
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
                      Observer(builder: (_) {
                        final recordRepository = getIt<RecordRepository>();
                        return Stack(children: [
                          const StatsChartGraph(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PersonAppBarLine("Records:",
                                  recordRepository.records.length.toString()),
                              PersonAppBarLine(
                                  "Known words:",
                                  getIt<KnownRecordsRepository>()
                                      .count()
                                      .toString()),
                              PersonAppBarLine("reading:",
                                  "${(getIt<ActivityTimeRepository>().readingTimeInMinutes() / 60).toStringAsFixed(1)}H"),
                              PersonAppBarLine("training:",
                                  "${(getIt<ActivityTimeRepository>().learningTimeInMinutes() / 60).toStringAsFixed(1)}H"),
                              PersonAppBarLine("current streak:",
                                  "${getIt<TimeMarkRepository>().getStreak()}-days"),
                            ],
                          )
                        ]);
                      })
                    ],
                  )),
            ),
          ),
        ));
  }
}
