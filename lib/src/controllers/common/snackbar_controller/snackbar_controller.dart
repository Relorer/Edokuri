// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class SnackbarController {
  Future<SnackBarClosedReason> showDefaultSnackbar(
      BuildContext context, String message, int seconds, String label) async {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            duration: Duration(seconds: seconds),
            content: Text(message),
            action: SnackBarAction(
              label: label,
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            )))
        .closed;
  }
}
