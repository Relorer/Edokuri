import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/app_bar_title.dart';
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
      flexibleSpace: SingleChildScrollView(
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
                  Material(
                      color: Colors.transparent,
                      child: Container(
                        width: double.maxFinite,
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(doubleDefaultMargin),
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
                      )),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        PersonAppBarLine("Records:", "743"),
                        PersonAppBarLine("Known words:", "743"),
                        PersonAppBarLine("reading:", "743"),
                        PersonAppBarLine("training:", "743"),
                        PersonAppBarLine("current streak:", "743"),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
