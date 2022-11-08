import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';

class MainNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const MainNavigation(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const items = [shelfSvg, openBookSvg, personSvg];

    return NavigationBar(
      backgroundColor: Theme.of(context).secondBackgroundColor,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      surfaceTintColor: Colors.amber,
      onDestinationSelected: onTap,
      height: 55,
      selectedIndex: currentIndex,
      destinations: items
          .map((e) => NavigationDestination(
                label: '',
                icon: SvgPicture.asset(
                  e,
                  color: currentIndex == items.indexOf(e)
                      ? Theme.of(context).brightElementColor
                      : Theme.of(context).paleElementColor,
                ),
              ))
          .toList(),
    );
    return CustomNavigationBar(
      backgroundColor: Theme.of(context).secondBackgroundColor,
      selectedColor: Theme.of(context).brightElementColor,
      unSelectedColor: Theme.of(context).paleElementColor,
      strokeColor: Theme.of(context).secondBackgroundColor,
      scaleFactor: 0.001,
      elevation: 0,
      items: items
          .map((e) => CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  e,
                  color: currentIndex == items.indexOf(e)
                      ? Theme.of(context).brightElementColor
                      : Theme.of(context).paleElementColor,
                ),
              ))
          .toList(),
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
