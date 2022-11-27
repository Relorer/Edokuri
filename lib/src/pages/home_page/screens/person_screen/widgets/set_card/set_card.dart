import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:freader/src/controllers/stores/set_controller/set_controller.dart';
import 'package:freader/src/core/utils/records_list_extensions.dart';
import 'package:freader/src/core/widgets/ellipsis_text.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/models/set.dart';
import 'package:freader/src/pages/home_page/screens/person_screen/widgets/set_card/set_card_dialog.dart';
import 'package:freader/src/pages/set_page/set_page.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class SetCard extends StatelessWidget {
  final SetRecords set;

  const SetCard(
    this.set, {
    super.key,
  });

  void _openSet(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Observer(builder: (_) {
          return SetPage(
            setController: SetData(set.records, set: set),
          );
        }),
      ),
    );
  }

  void _removeSet(BuildContext context) {
    context.read<SetRepository>().removeSet(set);
    Navigator.pop(context);
  }

  void _openEditingSet(BuildContext context) {}

  void _longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SetCardDialog(
        openSet: () {
          Navigator.pop(context);
          _openSet(context);
        },
        removeSet: () => _removeSet(context),
        openEditingSet: () => _openEditingSet(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: () => _openSet(context),
      onLongPress: () => _longPressHandler(context),
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: doubleDefaultMargin, vertical: doubleDefaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EllipsisText(
                set.name.isEmpty ? "No name" : set.name,
                style: Theme.of(context).bookTitleStyle,
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              EllipsisText(
                "${set.records.saved.length} records",
                style: Theme.of(context).cardSubtitleStyle,
              ),
            ],
          )),
    );
  }
}
