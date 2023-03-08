import 'package:flutter/material.dart';
import 'package:edokuri/src/controllers/stores/set_controller/set_controller.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
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
          appBar: PhantomAppBar(),
          body: SetScreen(
            setData: setData,
          ),
        ));
  }
}
