// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_dialog/adaptive_dialog.dart';

// 🌎 Project imports:
import 'package:edokuri/src/theme/theme_consts.dart';

Future<OkCancelResult> showOkCancelAlertDialogStyled({
  required BuildContext context,
  String? title,
  String? message,
  String? okLabel,
  String? cancelLabel,
}) async {
  return showOkCancelAlertDialog(
    context: context,
    title: title,
    message: message,
    okLabel: okLabel,
    cancelLabel: cancelLabel,
    cancelButtonLabelStyle: const TextStyle(color: Color(0xffF0BFA2)),
    okButtonLabelStyle: const TextStyle(color: white),
    builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)),
        child: Material(
          color: Colors.transparent,
          child: child,
        )),
  );
}
