import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/theme/theme.dart';

const _setSystemUIOverlayStyleTag = "setSystemUIOverlayStyleTag";
const _timeStampBetween = 300;

void setUpBarDefaultStyles(BuildContext context) {
  EasyDebounce.debounce(_setSystemUIOverlayStyleTag,
      const Duration(milliseconds: _timeStampBetween), () {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
    ));
  });
}

void setUpBarReaderStyles(BuildContext context) {
  EasyDebounce.debounce(_setSystemUIOverlayStyleTag,
      const Duration(milliseconds: _timeStampBetween), () {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.background,
    ));
  });
}
