// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/set_controller/set_controller.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/pages/home_page/utils/app_bar.dart';
import 'package:edokuri/src/pages/set_page/widgets/cards_section_header.dart';
import 'package:edokuri/src/pages/set_page/widgets/record_cards_list.dart';
import 'package:edokuri/src/pages/set_page/widgets/records_app_bar.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_cards_list.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_section_header.dart';

class SetScreen extends StatelessWidget {
  final SetData setData;

  SetScreen({Key? key, required this.setData}) : super(key: key);

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BouncingCustomScrollView(
        controller: controller,
        slivers: [
          RecordsAppBar(
            setData: setData,
            appBarHeight: getAppBarHeight(context),
            resetScrollClick: () => controller.animateTo(0,
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn),
          ),
          const StudyingSectionHeader(),
          StudyingCardsList(
            setData: setData,
          ),
          const CardsSectionHeader(),
          RecordCardsList(
            setData: setData,
          ),
        ],
      )),
    );
  }
}
