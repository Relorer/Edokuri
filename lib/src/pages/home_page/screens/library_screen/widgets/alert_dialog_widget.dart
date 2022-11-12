import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/file_controller/provider_file_controller.dart';
import 'package:freader/src/controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/library_sort_controller/provider_library_sort_controller.dart';
import 'package:freader/src/core/button_with_icon.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';

class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({Key? key}) : super(key: key);

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  _addButtonHandler() {
    ProviderFileController.ctr(context).getBookFromUser();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(24),
        backgroundColor: Theme.of(context).secondBackgroundColor,
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonWithIcon(
                text: "Upload new book",
                onTap: _addButtonHandler,
                svg: uploadSvg,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Sort by:",
                style: Theme.of(context)
                    .dialogTextStyle
                    .copyWith(color: Theme.of(context).paleElementColor),
              ),
              const SizedBox(
                height: 10,
              ),
              ...SortTypes.values.map((e) => ListTile(
                    horizontalTitleGap: 15,
                    minVerticalPadding: 0,
                    minLeadingWidth: 0,
                    dense: true,
                    title: Text(
                      getSortTypeName(e),
                      style: Theme.of(context).dialogTextStyle,
                    ),
                    contentPadding: EdgeInsets.zero,
                    leading: Observer(builder: (_) {
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
                        groupValue:
                            ProviderLibrarySortController.ctr(context).sortType,
                        onChanged: (SortTypes? value) {
                          ProviderLibrarySortController.ctr(context)
                              .setSortType(value!);
                        },
                      );
                    }),
                  )),
            ],
          ),
        ));
  }
}
