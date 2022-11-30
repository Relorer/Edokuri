import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:provider/provider.dart';

class LearnPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LearnPageAppBar({Key? key, this.settingsClick})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final VoidCallback? settingsClick;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).secondBackgroundColor,
      elevation: 0,
      title: Observer(builder: (_) {
        final learnController = context.read<LearnController>();
        return Center(
            child: Text(
                "${learnController.currentRecord + 1}/${learnController.records.length}"));
      }),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: settingsClick,
        ),
      ],
    );
  }
}
