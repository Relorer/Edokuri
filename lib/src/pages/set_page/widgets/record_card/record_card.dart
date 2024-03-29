// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/alert_dialog.dart';
import 'package:edokuri/src/core/widgets/simple_card.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:edokuri/src/pages/set_page/widgets/record_card/record_card_dialog.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordCard extends StatelessWidget {
  final SetData setData;
  final Record record;

  const RecordCard(this.record, {super.key, required this.setData});

  void _openRecordInfo(BuildContext context) {
    TapOnWordHandlerProvider.of(context).tapOnWordHandler(record.original, "");
  }

  void _removeRecord(BuildContext context) async {
    final result = await showOkCancelAlertDialogStyled(
      context: context,
      title: "Are you sure you want to delete \"${record.original}\" record?",
      okLabel: "Yes",
    );
    if (result == OkCancelResult.ok) {
      getIt<RecordRepository>().removeRecord(record, set: setData.set);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _resetProgress(BuildContext context) async {
    final result = await showOkCancelAlertDialogStyled(
      context: context,
      title:
          "Are you sure you want to reset the progress for \"${record.original}\" record?",
      okLabel: "Yes",
    );
    if (result == OkCancelResult.ok) {
      getIt<RecordRepository>().resetProgress(record);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _longPressHandler(BuildContext context) {
    showModalBottomSheet<void>(
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => RecordCardDialog(
        openRecord: () {
          Navigator.pop(context);
          _openRecordInfo(context);
        },
        removeSet: () => _removeRecord(context),
        resetProgress: () => _resetProgress(context),
        updateTranslation: () async {
          Navigator.pop(context);
          await getIt<RecordRepository>().updateTranslation(record);
          getIt<ToastController>().showDefaultTost("Re-Translate done");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      onTap: () => _openRecordInfo(context),
      onLongPress: () => _longPressHandler(context),
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: doubleDefaultMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: record.original,
                          style: Theme.of(context).cardTitleStyle,
                        ),
                        const TextSpan(text: " "),
                        TextSpan(
                          text: record.transcription,
                          style: Theme.of(context).cardSubtitleStyle,
                        ),
                      ])),
                    ),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        record.translation,
                        style: Theme.of(context).cardSubtitleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: defaultMargin,
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () =>
                      getIt<TTSController>().speak(record.original),
                  icon: SvgPicture.asset(
                    speakerSvg,
                    colorFilter:
                        const ColorFilter.mode(darkGray, BlendMode.srcIn),
                  )),
            ],
          )),
    );
  }
}
