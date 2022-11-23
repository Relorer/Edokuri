import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class SortTypesList extends StatelessWidget {
  const SortTypesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...BooksSortTypes.values.map((e) => GestureDetector(
            onTap: () => context.read<LibrarySortController>().setSortType(e),
            child: Container(
              color: Theme.of(context).secondBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(doubleDefaultMargin),
                child: Row(children: [
                  Observer(builder: (_) {
                    final librarySort = context.read<LibrarySortController>();

                    return Radio<BooksSortTypes>(
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
                      groupValue: librarySort.sortType,
                      onChanged: null,
                    );
                  }),
                  const SizedBox(
                    width: doubleDefaultMargin,
                  ),
                  Text(
                    getSortTypeName(e),
                    style: Theme.of(context).dialogTextStyleBright,
                  )
                ]),
              ),
            ),
          ))
    ]);
  }
}
