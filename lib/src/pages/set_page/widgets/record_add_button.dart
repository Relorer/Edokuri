// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/add_record_page/add_record_page.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_card/studying_card.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

// 📦 Package imports:

class RecordAddButton extends StatelessWidget {
  final SetRecords? setRecords;

  const RecordAddButton({super.key, this.setRecords});

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(
      Padding(
        padding: const EdgeInsets.fromLTRB(
            defaultMargin, 0, defaultMargin, defaultMargin),
        child: StudyingCard(
          title: 'Add new records',
          subTitle: 'Let\'s fill up the dictionary first',
          svg: addRecordSvg,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddRecordPage(
                  set: setRecords,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
