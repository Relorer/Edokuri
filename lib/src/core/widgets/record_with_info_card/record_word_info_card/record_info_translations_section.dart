// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:edokuri/src/core/widgets/translated_by.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

// 📦 Package imports:

class RecordInfoTranslationsSection extends StatefulWidget {
  final List<Translation> translations;
  final bool changeable;

  const RecordInfoTranslationsSection(
      {super.key, required this.translations, this.changeable = true});

  @override
  State<RecordInfoTranslationsSection> createState() =>
      _RecordInfoTranslationsSectionState();
}

class _RecordInfoTranslationsSectionState
    extends State<RecordInfoTranslationsSection> {
  final TextEditingController _textEditingController = TextEditingController();
  late List<Translation> translations = widget.translations;

  @override
  initState() {
    super.initState();
  }

  void _fieldSubmittedHandler(String value) {
    setState(() {
      value = value.trim().toLowerCase();

      if (translations.any((element) => element.text == value)) {
        translations.firstWhere((element) => element.text == value).selected =
            true;
      } else {
        translations
            .add(Translation(value, source: userSource, selected: true));
      }

      _textEditingController.clear();
    });
  }

  Function(bool) getOnSelected(int index) => widget.changeable
      ? (bool selected) {
          setState(() {
            translations[index].selected = !translations[index].selected;
            translations[index].selectionDate =
                selected ? DateTime.now().toUtc() : null;
          });
        }
      : (_) => {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: defaultMargin / 2,
          runSpacing: defaultMargin / 2,
          children: List<Widget>.generate(
            translations.length,
            (int index) {
              return translations[index].text.length > maxPhraseLength
                  ? ChoiceChip(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(defaultRadius),
                        ),
                      ),
                      pressElevation: 3,
                      selectedColor: widget.changeable
                          ? Theme.of(context).unknownWordColor.withOpacity(0.6)
                          : Theme.of(context).unknownWordColor.withOpacity(0.2),
                      backgroundColor:
                          Theme.of(context).unknownWordColor.withOpacity(0.2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: 0.0),
                      label: Text(
                        translations[index].text,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        maxLines: 10000,
                      ),
                      selected: translations[index].selected,
                      onSelected: getOnSelected(index),
                    )
                  : ChoiceChip(
                      pressElevation: 3,
                      selectedColor: widget.changeable
                          ? Theme.of(context).unknownWordColor.withOpacity(0.6)
                          : Theme.of(context).unknownWordColor.withOpacity(0.2),
                      backgroundColor:
                          Theme.of(context).unknownWordColor.withOpacity(0.2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.all(0),
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: 0),
                      label: Text(
                        translations[index].text,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        maxLines: 10000,
                      ),
                      selected: translations[index].selected,
                      onSelected: getOnSelected(index),
                    );
            },
          ).toList(),
        ),
        translations.first.source != ""
            ? TranslatedBy(source: translations.first.source)
            : Container(),
        widget.changeable
            ? Padding(
                padding: const EdgeInsets.only(top: defaultMargin),
                child: TextFormFieldDefault(
                  controller: _textEditingController,
                  onFieldSubmitted: _fieldSubmittedHandler,
                  labelText: 'Enter your translate',
                ))
            : Container()
      ],
    );
  }
}
