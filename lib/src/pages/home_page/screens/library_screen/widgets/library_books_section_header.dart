// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header_text.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class LibraryBooksSectionHeader extends StatelessWidget {
  const LibraryBooksSectionHeader({super.key});

  _upload(BuildContext context) {
    getIt<FileController>().getBookFromUser();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeaderText(
      leftText: LocaleKeys.library.tr(),
      menuDialogChildren: [
        ButtonWithIcon(
          text: LocaleKeys.uploadNewBook.tr(),
          onTap: () => _upload(context),
          svg: uploadSvg,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultMargin, horizontal: doubleDefaultMargin),
          child: Text(
            LocaleKeys.sortBy.tr(),
            style: Theme.of(context).dialogTextStylePale,
          ),
        ),
        const SortTypesList<BooksSortTypes, Book, LibrarySortController>(
            BooksSortTypes.values),
      ],
    );
  }
}
