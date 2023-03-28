// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:edokuri/src/models/recordState/record_state.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LearnPageHeader extends StatelessWidget {
  const LearnPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE6E7E8),
      height: 35,
      child: Observer(builder: (context) {
        final learnController = context.read<LearnController>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: doubleDefaultMargin),
          child: Row(children: [
            Expanded(
                child: Text(
              learnController.newbornCount,
              textAlign: TextAlign.center,
              style: Theme.of(context).sectorTitleStye.copyWith(
                  color: const Color(0xFF4285F4),
                  decoration:
                      learnController.currentRecordState == RecordState.newborn
                          ? TextDecoration.underline
                          : TextDecoration.none),
            )),
            Expanded(
                child: Text(
              learnController.studiedCount,
              textAlign: TextAlign.center,
              style: Theme.of(context).sectorTitleStye.copyWith(
                  color: const Color(0xFFCE4003),
                  decoration:
                      learnController.currentRecordState == RecordState.studied
                          ? TextDecoration.underline
                          : TextDecoration.none),
            )),
            Expanded(
                child: Text(
              learnController.repeatableCount,
              textAlign: TextAlign.center,
              style: Theme.of(context).sectorTitleStye.copyWith(
                  color: const Color(0xFF34A853),
                  decoration: learnController.currentRecordState ==
                          RecordState.repeatable
                      ? TextDecoration.underline
                      : TextDecoration.none),
            )),
          ]),
        );
      }),
    );
  }
}
