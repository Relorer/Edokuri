// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/search_record_controller/search_record_controller.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/utils/app_bar.dart';
import 'package:edokuri/src/pages/set_page/widgets/cards_section_header.dart';
import 'package:edokuri/src/pages/set_page/widgets/record_cards_list.dart';
import 'package:edokuri/src/pages/set_page/widgets/records_app_bar.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_cards_list.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_section_header.dart';

class SetScreen extends StatelessWidget {
  final SearchRecordController _searchRecordController =
      SearchRecordController();
  final SetData _setData;

  SetScreen({Key? key, required SetData setData})
      : _setData = setData,
        super(key: key);

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchRecordController>(
            create: (_) => _searchRecordController),
      ],
      child: Scaffold(
        body: SafeArea(
            child: BouncingCustomScrollView(
          controller: controller,
          slivers: [
            RecordsAppBar(
              setData: _setData,
              appBarHeight: getAppBarHeight(context),
              resetScrollClick: () => controller.animateTo(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn),
            ),
            const StudyingSectionHeader(),
            StudyingCardsList(
              setData: _setData,
            ),
            const CardsSectionHeader(),
            RecordCardsList(
              setData: _setData,
            ),
          ],
        )),
      ),
    );
  }
}
