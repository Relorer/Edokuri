import 'package:flutter/widgets.dart';
import 'package:freader/src/models/set.dart';
import 'package:freader/src/pages/home_page/screens/person_screen/widgets/set_card/set_card.dart';
import 'package:freader/src/theme/theme_consts.dart';

class SetCardsList extends StatelessWidget {
  const SetCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final studying = [
      SetCard(SetRecords(name: "Test")),
      SetCard(SetRecords(name: "Test"))
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
