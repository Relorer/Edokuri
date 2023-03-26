// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/learn_page/learn_page.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_card/studying_card.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class StudyingCardsList extends StatelessWidget {
  final SetData setData;

  const StudyingCardsList({super.key, required this.setData});

  @override
  Widget build(BuildContext context) {
    final studying = [
      Observer(builder: (context) {
        return StudyingCard(
          title: 'Learn',
          subTitle: 'Focus your studying with a path',
          svg: learnSvg,
          onTap: setData.records.isEmpty
              ? null
              : (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LearnPage(
                        setData: setData,
                        records: setData.records,
                      ),
                    ),
                  );
                }),
        );
      }),
      // StudyingCard(
      //   title: 'Test',
      //   subTitile: 'Take a practice test',
      //   svg: testSvg,
      //   onTap: setData.records.isEmpty ? null : (() {}),
      // )
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultMargin, 0, defaultMargin, defaultMargin),
                child: studying[index],
              ),
          childCount: studying.length),
    );
  }
}
