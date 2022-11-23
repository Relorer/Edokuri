import 'package:flutter/widgets.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/studying_card/studying_card.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme_consts.dart';

class StudyingCardsList extends StatelessWidget {
  const StudyingCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final studying = [
      StudyingCard(
        title: 'Learn',
        subTitile: 'Focus your studying with a path',
        svg: learnSvg,
        onTap: (() {}),
      ),
      StudyingCard(
        title: 'Test',
        subTitile: 'Take a practice test',
        svg: testSvg,
        onTap: (() {}),
      )
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
