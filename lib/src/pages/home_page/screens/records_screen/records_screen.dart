// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/set_controller/set_controller.dart';
import 'package:edokuri/src/core/utils/records_list_extensions.dart';
import 'package:edokuri/src/pages/set_page/set_screen.dart';

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
        setData: SetData(context.read<RecordRepository>().records.saved),
      );
    });
  }
}
