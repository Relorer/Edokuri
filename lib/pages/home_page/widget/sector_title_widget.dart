import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freader/theme.dart';

class SectorTitleWidget extends StatelessWidget {
  final String leftText;
  final VoidCallback? onPressed;

  const SectorTitleWidget({Key? key, required this.leftText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: Theme.of(context).sectorTitleStye,
          ),
          onPressed != null
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: SvgPicture.asset(
                    "assets/icons/menu.svg",
                    color: Theme.of(context).paleElementColor,
                  ),
                  onPressed: onPressed,
                )
              : Container(),
        ],
      ),
    );
  }
}
