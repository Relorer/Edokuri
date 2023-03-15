// 📦 Package imports:
import 'package:flutter/material.dart';

class SnackbarController {
  Future<SnackBarClosedReason> showDefaultSnackbar(
      BuildContext context, String message) async {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            duration: const Duration(days: 1),
            content: Text(message),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            )))
        .closed;
  }
}
