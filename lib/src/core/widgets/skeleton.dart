import 'package:flutter/material.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class Skeleton extends StatelessWidget {
  final double w;
  final double h;
  final double? r;

  const Skeleton(this.w, this.h, {super.key, this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(r ?? defaultRadius),
      ),
      height: h,
      width: w,
    );
  }
}
