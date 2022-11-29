import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

AppBar secondBackgroundEmptyAppBar(BuildContext context) => AppBar(
      toolbarHeight: 0,
      backgroundColor: Theme.of(context).secondBackgroundColor,
      elevation: 0,
    );
