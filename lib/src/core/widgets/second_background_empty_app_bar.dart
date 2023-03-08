// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/src/theme/theme.dart';

class PhantomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;

  const PhantomAppBar({
    Key? key,
    this.color,
  })  : preferredSize = const Size.fromHeight(0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Theme.of(context).secondBackgroundColor,
      elevation: 0,
    );
  }
}
