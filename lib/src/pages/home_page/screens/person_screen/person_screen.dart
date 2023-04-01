// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/set_add_button.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/person_app_bar/person_app_bar.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/set_cards_list.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/sets_section_header.dart';
import 'package:edokuri/src/pages/home_page/utils/app_bar.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final setRepository = getIt<SetRecordsRepository>();
      return BouncingCustomScrollView(
        slivers: [
          PersonAppBar(appBarHeight: getAppBarHeight(context)),
          SliverSingleChild(Visibility(
              replacement: const SizedBox(height: 3),
              visible: setRepository.isLoading,
              child: const LinearProgressIndicator(
                minHeight: 3,
                color: lightGray,
              ))),
          const SetsSectionHeader(),
          const SetCardsList(),
          setRepository.isLoading
              ? const SliverSingleChild(SizedBox())
              : setRepository.sets.isEmpty
                  ? const SetAddButton()
                  : const SliverSingleChild(SizedBox()),
        ],
      );
    });
  }
}
