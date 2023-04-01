// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/section_dialog.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SectionHeader extends StatelessWidget {
  final Widget leftChild;
  final List<Widget>? menuDialogChildren;

  const SectionHeader(
      {Key? key, required this.leftChild, this.menuDialogChildren})
      : super(key: key);

  void _menuButtonHandler(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.transparent,
      context: context,
      pageBuilder: (BuildContext _, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SectionDialog(menuDialogChildren!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(Padding(
      padding: const EdgeInsets.all(doubleDefaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: leftChild),
          menuDialogChildren != null
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: SvgPicture.asset(
                    menuSvg,
                    height: 12,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).lightGrayColor, BlendMode.srcIn),
                  ),
                  onPressed: () => _menuButtonHandler(context),
                )
              : Container(
                  height: 24,
                ),
        ],
      ),
    ));
  }
}
