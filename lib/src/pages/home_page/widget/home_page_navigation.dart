// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/safe_area_with_settings.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';

class HomePageNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const HomePageNavigation(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const items = [shelfSvg, openBookSvg, personSvg];

    return Theme(
        data: basicTheme(Brightness.light)
            .copyWith(splashFactory: NoSplash.splashFactory),
        child: SafeAreaWithSettings(
          child: NavigationBar(
            backgroundColor: Theme.of(context).secondBackgroundColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: onTap,
            height: 55,
            elevation: 0,
            selectedIndex: currentIndex,
            destinations: items
                .map((e) => NavigationDestination(
                      label: '',
                      icon: SvgPicture.asset(
                        e,
                        colorFilter: ColorFilter.mode(
                            currentIndex == items.indexOf(e)
                                ? Theme.of(context).brightElementColor
                                : Theme.of(context).lightGrayColor,
                            BlendMode.srcIn),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}
