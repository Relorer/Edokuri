// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/set_card/set_card.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SetCardsList extends StatelessWidget {
  const SetCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final studying = getIt<SetRecordsRepository>()
          .sets
          .map((element) => SetCard(element))
          .toList();
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, defaultMargin),
                  child: studying[index],
                ),
            childCount: studying.length),
      );
    });
  }
}
