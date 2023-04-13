// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LibraryScreenLoading extends StatelessWidget {
  const LibraryScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(Observer(builder: (context) {
      final bookRepository = getIt<BookRepository>();
      return Visibility(
          replacement: const SizedBox(height: 3),
          visible: bookRepository.isLoading,
          child: const LinearProgressIndicator(
            minHeight: 3,
            color: lightGray,
          ));
    }));
  }
}
