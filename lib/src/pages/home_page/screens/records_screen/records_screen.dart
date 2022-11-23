import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/cards_section_header.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/record_cards_list.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/records_app_bar.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/studying_cards_list.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/studying_section_header.dart';
import 'package:freader/src/pages/home_page/utils/app_bar.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BouncingCustomScrollView(
      controller: controller,
      slivers: [
        RecordsAppBar(
          appBarHeight: getAppBarHeight(context),
          resetScrollClick: () => controller.animateTo(0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn),
        ),
        const StudyingSectionHeader(),
        const StudyingCardsList(),
        const CardsSectionHeader(),
        const RecordCardsList(),
      ],
    );
  }
}
