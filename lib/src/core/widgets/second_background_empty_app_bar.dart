import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

class SecondBackgroundEmptyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SecondBackgroundEmptyAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: Theme.of(context).secondBackgroundColor,
      elevation: 0,
    );
  }
}
