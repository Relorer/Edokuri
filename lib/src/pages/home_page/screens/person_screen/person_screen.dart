// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/person_app_bar/person_app_bar.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/set_cards_list.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/sets_section_header.dart';
import 'package:edokuri/src/pages/home_page/utils/app_bar.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    return BouncingCustomScrollView(
      slivers: [
        PersonAppBar(appBarHeight: getAppBarHeight(context)),
        const SetsSectionHeader(),
        const SetCardsList(),
      ],
    );
  }
}
