import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/records_list_extensions.dart';
import 'package:freader/src/pages/set_page/set_screen.dart';
import 'package:provider/provider.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SetScreen(
        records: context.read<DBController>().records.saved,
      );
    });
  }
}
