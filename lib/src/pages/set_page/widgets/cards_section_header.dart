// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header.dart';
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_without_paddings.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:edokuri/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class CardsSectionHeader extends StatefulWidget {
  const CardsSectionHeader({super.key});

  @override
  State<CardsSectionHeader> createState() => _CardsSectionHeaderState();
}

class _CardsSectionHeaderState extends State<CardsSectionHeader> {
  final TextEditingController textEditingController = TextEditingController();

  _onFieldSubmitted(String text) {
    TapOnWordHandlerProvider.of(context).tapOnWordHandler(text, "");
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      leftChild: Padding(
        padding: const EdgeInsets.only(right: defaultMargin),
        child: TextFormFieldWithoutPaddings(
          controller: textEditingController,
          onFieldSubmitted: _onFieldSubmitted,
          labelText: "Search",
        ),
      ),
      menuDialogChildren: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultMargin, horizontal: doubleDefaultMargin),
          child: Text(
            LocaleKeys.sortBy.tr(),
            style: Theme.of(context).dialogTextStylePale,
          ),
        ),
        const SortTypesList<RecordsSortTypes, Record, RecordsSortController>(
            RecordsSortTypes.values),
      ],
    );
  }
}
