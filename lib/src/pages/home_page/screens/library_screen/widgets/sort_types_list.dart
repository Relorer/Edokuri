import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/sort_controllers/base_sort_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class SortTypesList<Types extends Enum, ItemType,
        SortController extends BaseSortController<Types, ItemType>>
    extends StatelessWidget {
  final List<Types> sortTypes;
  const SortTypesList(this.sortTypes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...sortTypes.map((e) => GestureDetector(
            onTap: () => context.read<SortController>().setSortType(e),
            child: Container(
              color: Theme.of(context).secondBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(doubleDefaultMargin),
                child: Row(children: [
                  Observer(builder: (_) {
                    final librarySort = context.read<SortController>();

                    return Radio<Types>(
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
                    context.read<SortController>().getSortTypeName(e),
                    style: Theme.of(context).dialogTextStyleBright,
                  )
                ]),
              ),
            ),
          ))
    ]);
  }
}
