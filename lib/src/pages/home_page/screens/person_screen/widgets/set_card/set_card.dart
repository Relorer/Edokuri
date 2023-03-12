// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/controllers/stores/set_controller/set_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/records_list_extensions.dart';
import 'package:edokuri/src/core/widgets/ellipsis_text.dart';
import 'package:edokuri/src/core/widgets/simple_card.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/widgets/set_card/set_card_dialog.dart';
import 'package:edokuri/src/pages/set_editing_page/set_editign_page.dart';
import 'package:edokuri/src/pages/set_page/set_page.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SetCard extends StatelessWidget {
  final SetRecords set;

  const SetCard(
    this.set, {
    super.key,
  });

  void _openSet(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Observer(builder: (_) {
          return SetPage(
            setData: SetData(getIt<RecordRepository>().getRecordsBySet(set),
                set: set),
          );
        }),
      ),
    );
  }

  void _removeSet(BuildContext context) {
    getIt<SetRepository>().removeSet(set);
    Navigator.pop(context);
  }

  void _openEditingSet(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetEditingPage(
          set: set,
        ),
      ),
    );
  }

  void _longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.black26,
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
