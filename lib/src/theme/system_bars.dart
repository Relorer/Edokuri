import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/theme/theme.dart';

const _setSystemUIOverlayStyleTag = "setSystemUIOverlayStyleTag";
const _timeStampBetween = 300;

void setUpBarDefaultStyles(Color systemNavigationBarColor) {
  EasyDebounce.debounce(_setSystemUIOverlayStyleTag,
      const Duration(milliseconds: _timeStampBetween), () {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: systemNavigationBarColor,
    ));
  });
}
