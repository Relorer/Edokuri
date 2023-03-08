// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';

class RecordInfoHeader extends StatelessWidget {
  final String title;

  const RecordInfoHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        onTap: () {
          getIt<TTSController>().speak(title);
        },
        child: Text(
          title.contains(" ") ? title : title.toUpperCase(),
          textAlign: title.contains("\n") ? TextAlign.left : TextAlign.center,
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
