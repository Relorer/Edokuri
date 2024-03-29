// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/set_page/set_screen.dart';

class SetPage extends StatelessWidget {
  final SetData setData;

  const SetPage({Key? key, required this.setData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecordWithInfoCard(
        bottomPadding: 0,
        set: setData.set,
        body: Scaffold(
          appBar: const PhantomAppBar(),
          body: SetScreen(
            setData: setData,
          ),
        ));
  }
}
