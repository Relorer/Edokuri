import 'package:flutter/widgets.dart';
import 'package:freader/src/controllers/base_provider.dart';
import 'package:freader/src/controllers/library_sort_controller/library_sort_controller.dart';

class ProviderLibrarySortController
    extends BaseProvider<LibrarySortController> {
  ProviderLibrarySortController({super.key, required super.child})
      : super(controller: LibrarySortController());

  static LibrarySortController ctr(BuildContext context) =>
      BaseProvider.of<ProviderLibrarySortController>(context).controller;
}
