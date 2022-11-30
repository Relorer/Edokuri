import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

class SecondBackgroundEmptyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SecondBackgroundEmptyAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondBackgroundColor,
    );
  }
}
