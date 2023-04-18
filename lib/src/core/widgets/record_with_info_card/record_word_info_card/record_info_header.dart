// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordInfoHeader extends StatelessWidget {
  final String title;
  final String transcription;

  const RecordInfoHeader(this.title, this.transcription, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          getIt<TTSController>().speak(title);
        },
        child: Column(
          children: [
            Text(
              title.contains(" ") ? title : title.toUpperCase(),
              textAlign:
                  title.contains("\n") ? TextAlign.left : TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            transcription.isEmpty
                ? Container()
                : AutoSizeText(
                    textAlign: title.contains("\n")
                        ? TextAlign.left
                        : TextAlign.center,
                    transcription,
                    style: Theme.of(context).cardSubtitleStyle,
                  ),
            Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => getIt<TTSController>().speak(title),
                  icon: SvgPicture.asset(
                    speakerSvg,
                    colorFilter:
                        const ColorFilter.mode(darkGray, BlendMode.srcIn),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
