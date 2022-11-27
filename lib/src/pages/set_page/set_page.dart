import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/set_controller/set_controller.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:freader/src/pages/set_page/set_screen.dart';

class SetPage extends StatelessWidget {
  final SetData setController;

  const SetPage({Key? key, required this.setController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecordWithInfoCard(
        body: SetScreen(
      setData: setController,
    ));
  }
}
