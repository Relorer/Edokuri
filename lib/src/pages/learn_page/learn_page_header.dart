// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LearnPageHeader extends StatelessWidget {
  final int newRecords;
  final int studiedRecords;
  final int reviewedRecords;

  const LearnPageHeader(
      {super.key,
      required this.newRecords,
      required this.reviewedRecords,
      required this.studiedRecords});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE6E7E8),
      height: 35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: doubleDefaultMargin),
        child: Row(children: [
          Expanded(
              child: Text(
            newRecords.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .sectorTitleStye
                .copyWith(color: const Color(0xFF4285F4)),
          )),
          Expanded(
              child: Text(
            studiedRecords.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).sectorTitleStye.copyWith(
                color: const Color(0xFFCE4003),
                decoration: TextDecoration.underline),
          )),
          Expanded(
              child: Text(
            reviewedRecords.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .sectorTitleStye
                .copyWith(color: const Color(0xFF34A853)),
          )),
        ]),
      ),
    );
  }
}
