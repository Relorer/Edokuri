import 'dart:typed_data';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';

class BookCardCover extends StatelessWidget {
  final Uint8List? cover;

  const BookCardCover({super.key, this.cover});

  @override
  Widget build(BuildContext context) {
    return cover != null
        ? Ink.image(
            height: 110,
            width: 70,
            fit: BoxFit.fitHeight,
            image: MemoryImage(cover!))
        : Container(
            height: 110,
            width: 70,
            color: Theme.of(context).paleElementColor.withOpacity(0.6),
            child: Center(
                child: SvgPicture.asset(
              imageSvg,
              color: Colors.white.withOpacity(0.8),
            )),
          );
  }
}
