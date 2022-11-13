import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/library_sort_controller/provider_library_sort_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class SortTypesList extends StatelessWidget {
  const SortTypesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...SortTypes.values.map((e) => ListTile(
              horizontalTitleGap: defaultMargin,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              dense: true,
              title: Text(
                getSortTypeName(e),
                style: Theme.of(context).dialogTextStyleBright,
              ),
              contentPadding: EdgeInsets.zero,
              leading: Observer(builder: (_) {
                final sortCtr = ProviderLibrarySortController.ctr(context);
                return Radio<SortTypes>(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  fillColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    return Theme.of(context).paleElementColor;
                  }),
                  value: e,
                  groupValue: sortCtr.sortType,
                  onChanged: sortCtr.setSortType,
                );
              }),
            ))
      ],
    );
  }
}
