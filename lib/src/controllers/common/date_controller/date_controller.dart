// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// 📦 Package imports:
import 'package:http/http.dart' as http;

class DateControllerFactory {
  Future<DateTime> _getServerTime() async {
    try {
      final response =
          await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final serverTime = DateTime.parse(json['datetime']).toUtc();
        return serverTime;
      } else {
        return DateTime.now().toUtc();
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      return DateTime.now().toUtc();
    }
  }

  Future<DateController> getDateController() async {
    final serverTime = await _getServerTime();
    final now = DateTime.now().toUtc();
    final difference = now.difference(serverTime);
    return DateController(difference);
  }
}

class DateController {
  Duration difference;

  DateController(this.difference);

  DateTime now() {
    return DateTime.now().toUtc().subtract(difference);
  }
}
