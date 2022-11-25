import 'package:freader/generated/locale.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:freader/src/core/widgets/section_header.dart';
import 'package:freader/src/core/widgets/button_with_icon.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class CardsSectionHeader extends StatelessWidget {
  const CardsSectionHeader({super.key});

  _addNewRecord(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      leftText: "Cards",
      menuDialogChildren: [
        ButtonWithIcon(
          text: "Add new record",
          onTap: () => _addNewRecord(context),
          svg: createSvg,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultMargin, horizontal: doubleDefaultMargin),
          child: Text(
            LocaleKeys.sort_by.tr(),
            style: Theme.of(context).dialogTextStylePale,
          ),
        ),
        const SortTypesList<RecordsSortTypes, Record, RecordsSortController>(
            RecordsSortTypes.values),
      ],
    );
  }
}
