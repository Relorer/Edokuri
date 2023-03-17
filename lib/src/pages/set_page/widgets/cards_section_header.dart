// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_debounce/easy_debounce.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/locale.dart';
import 'package:edokuri/src/controllers/stores/search_record_controller/search_record_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header.dart';
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_without_paddings.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/add_record_page/add_record_page.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/widgets/sort_types_list.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class CardsSectionHeader extends StatefulWidget {
  final SetRecords? set;
  const CardsSectionHeader({super.key, required this.set});

  @override
  State<CardsSectionHeader> createState() => _CardsSectionHeaderState();
}

class _CardsSectionHeaderState extends State<CardsSectionHeader> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      EasyDebounce.debounce('search-records', const Duration(seconds: 1), () {
        if (mounted) {
          context
              .read<SearchRecordController>()
              .setNewRequest(textEditingController.text);
        }
      });
    });
  }

  _onFieldSubmitted(String text) {}

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
        ButtonWithIcon(
          text: "Add new records",
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddRecordPage(
                set: widget.set,
              ),
            ),
          ),
          svg: addRecordSvg,
        ),
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
