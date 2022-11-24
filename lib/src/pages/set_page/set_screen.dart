import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/set_page/widgets/cards_section_header.dart';
import 'package:freader/src/pages/set_page/widgets/record_cards_list.dart';
import 'package:freader/src/pages/set_page/widgets/records_app_bar.dart';
import 'package:freader/src/pages/set_page/widgets/studying_cards_list.dart';
import 'package:freader/src/pages/set_page/widgets/studying_section_header.dart';
import 'package:freader/src/pages/home_page/utils/app_bar.dart';

class SetScreen extends StatefulWidget {
  final List<Record> records;

  const SetScreen({Key? key, required this.records}) : super(key: key);

  @override
  State<SetScreen> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BouncingCustomScrollView(
        controller: controller,
        slivers: [
          RecordsAppBar(
            records: widget.records,
            appBarHeight: getAppBarHeight(context),
            resetScrollClick: () => controller.animateTo(0,
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn),
          ),
          const StudyingSectionHeader(),
          const StudyingCardsList(),
          const CardsSectionHeader(),
          RecordCardsList(widget.records),
        ],
      )),
    );
  }
}
