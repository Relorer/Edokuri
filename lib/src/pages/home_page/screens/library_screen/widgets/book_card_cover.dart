import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

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
            color: Theme.of(context).paleElementColor,
            child: const Center(
                child: Text(
              "cover",
              style: TextStyle(color: Colors.white60),
            )),
          );
  }
}
