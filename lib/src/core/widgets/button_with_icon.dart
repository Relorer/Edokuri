import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/theme/theme.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final String svg;
  final GestureTapCallback? onTap;

  const ButtonWithIcon(
      {Key? key, required this.svg, this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3),
        child: Row(children: [
          SvgPicture.asset(
            svg,
            color: Theme.of(context).paleElementColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: Theme.of(context).dialogTextStyleBright,
          )
        ]),
      ),
    );
  }
}
