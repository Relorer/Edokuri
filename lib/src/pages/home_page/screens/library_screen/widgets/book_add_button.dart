// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/set_page/widgets/studying_card/studying_card.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

// 📦 Package imports:

class BookAddButton extends StatelessWidget {
  const BookAddButton({super.key});

  _upload(BuildContext context) {
    getIt<FileController>().getBookFromUser();
  }

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(
      Padding(
        padding: const EdgeInsets.fromLTRB(
            defaultMargin, 0, defaultMargin, defaultMargin),
        child: StudyingCard(
          width: 16,
          title: 'Upload a new book',
          subTitle: 'Use epub format',
          svg: uploadSvg,
          onTap: () => _upload(context),
        ),
      ),
    );
  }
}
