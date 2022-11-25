import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/section_header.dart';
import 'package:freader/src/controllers/common/file_controller/file_controller.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LibraryBooksSectionHeader extends StatelessWidget {
  const LibraryBooksSectionHeader({super.key});

  _upload(BuildContext context) {
    getIt<FileController>().getBookFromUser();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      leftText: LocaleKeys.library.tr(),
      menuDialogChildren: [
        ButtonWithIcon(
          text: LocaleKeys.upload_new_book.tr(),
          onTap: () => _upload(context),
          svg: uploadSvg,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultMargin, horizontal: doubleDefaultMargin),
          child: Text(
            LocaleKeys.sort_by.tr(),
            style: Theme.of(context).dialogTextStylePale,
          ),
        ),
        const SortTypesList<BooksSortTypes, Book, LibrarySortController>(
            BooksSortTypes.values),
      ],
    );
  }
}
