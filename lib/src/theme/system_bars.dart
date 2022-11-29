import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/theme/theme.dart';

const _setSystemUIOverlayStyleTag = "setSystemUIOverlayStyleTag";
const _timeStampBetween = 10;

void setUpBarDefaultStyles(BuildContext context) {
  EasyDebounce.debounce(_setSystemUIOverlayStyleTag,
      const Duration(milliseconds: _timeStampBetween), () {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
      statusBarColor: Theme.of(context).secondBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));
  });
}

void setUpBarDarkedStyles(BuildContext context) {
  EasyDebounce.debounce(_setSystemUIOverlayStyleTag,
      const Duration(milliseconds: _timeStampBetween), () {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffc2c2c2),
      statusBarIconBrightness: Brightness.dark,
    ));
  });
}

void setUpBarReaderStyles(BuildContext context) {
  EasyDebounce.debounce(_setSystemUIOverlayStyleTag,
      const Duration(milliseconds: _timeStampBetween), () {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.background,
      statusBarColor: Theme.of(context).colorScheme.background,
      statusBarIconBrightness: Brightness.dark,
    ));
  });
}
