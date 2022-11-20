import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/file_controller/file_controller.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_section_dialog/sort_types_list.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).secondBackgroundColor,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SortTypesList(),
                const SizedBox(
                  height: doubleDefaultMargin,
                ),
                SizedBox(
                    width: double.maxFinite,
                    child: Material(
                      color: Theme.of(context).secondBackgroundColor,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(doubleDefaultMargin),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).dialogTextStyleBright,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: doubleDefaultMargin,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
