// 📦 Package imports:
import 'package:fluttertoast/fluttertoast.dart';

class ToastController {
  void showDefaultTost(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 15.0);
  }
}
