import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/set_page/set_screen.dart';

class SetPage extends StatelessWidget {
  final List<Record> records;

  const SetPage({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecordWithInfoCard(body: SetScreen(records: records));
  }
}
