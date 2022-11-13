import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/theme/theme.dart';

void setUpBarDefaultStyles(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
    statusBarColor: Theme.of(context).secondBackgroundColor,
    statusBarIconBrightness: Brightness.light,
  ));
}

void setUpBarReaderStyles(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Theme.of(context).colorScheme.background,
    statusBarColor: Theme.of(context).colorScheme.background,
    statusBarIconBrightness: Brightness.dark,
  ));
}
