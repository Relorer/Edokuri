import 'package:flutter/widgets.dart';
import 'package:freader/objectbox.g.dart';
import 'package:freader/src/controllers/base_provider.dart';

import 'db_controller.dart';

class ProviderDbController extends BaseProvider<DBController> {
  ProviderDbController({super.key, required super.child, required Store store})
      : super(controller: DBController(store));

  static DBController ctr(BuildContext context) =>
      BaseProvider.of<ProviderDbController>(context).controller;
}
