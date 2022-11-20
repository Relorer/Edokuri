import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/widgets/records_app_bar.dart';
import 'package:freader/src/pages/home_page/utils/app_bar.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return BouncingCustomScrollView(
      slivers: [
        RecordsAppBar(appBarHeight: getAppBarHeight(context)),
      ],
    );
  }
}
