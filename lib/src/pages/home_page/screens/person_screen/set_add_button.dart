// 🐦 Flutter imports:
import 'package:edokuri/src/pages/set_editing_page/set_editign_page.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/add_record_page/add_record_page.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_card/studying_card.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

// 📦 Package imports:

class SetAddButton extends StatelessWidget {
  const SetAddButton({super.key});

  _creatNewSet(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SetEditingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(
      Padding(
        padding: const EdgeInsets.fromLTRB(
            defaultMargin, 0, defaultMargin, defaultMargin),
        child: StudyingCard(
          title: 'Create new set',
          subTitle: 'Sets of records not tied to a book',
          svg: addRecordSvg,
          onTap: () => _creatNewSet(context),
        ),
      ),
    );
  }
}
