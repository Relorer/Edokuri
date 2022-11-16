import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/file_controller/file_controller.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class BooksSectionDialog extends StatelessWidget {
  const BooksSectionDialog({super.key});

  _upload(BuildContext context) {
    context.read<FileController>().getBookFromUser();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(doubleDefaultMargin),
        backgroundColor: Theme.of(context).secondBackgroundColor,
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonWithIcon(
                text: LocaleKeys.upload_new_book.tr(),
                onTap: () => _upload(context),
                svg: uploadSvg,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultMargin),
                child: Text(
                  LocaleKeys.sort_by.tr(),
                  style: Theme.of(context).dialogTextStylePale,
                ),
              ),
              const SortTypesList(),
            ],
          ),
        ));
  }
}
