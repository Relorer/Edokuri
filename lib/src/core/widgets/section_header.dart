import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freader/src/core/widgets/section_dialog.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class SectionHeader extends StatelessWidget {
  final String leftText;
  final List<Widget>? menuDialogChildren;

  const SectionHeader(
      {Key? key, required this.leftText, this.menuDialogChildren})
      : super(key: key);

  void menuButtonHandler(BuildContext context) {
    showGeneralDialog(
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
          Text(
            leftText,
            style: Theme.of(context).sectorTitleStye,
          ),
          menuDialogChildren != null
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: SvgPicture.asset(
                    menuSvg,
                    color: Theme.of(context).paleElementColor,
                  ),
                  onPressed: () => menuButtonHandler(context),
                )
              : Container(),
        ],
      ),
    ));
  }
}
