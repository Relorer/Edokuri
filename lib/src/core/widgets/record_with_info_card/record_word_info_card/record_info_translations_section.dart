import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/controllers/common/translator_controller/translator_controller.dart';
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

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
              return ChoiceChip(
                shape: translations[index].source == googleSource ||
                        translations[index].text.length > maxPhraseLength
                    ? const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(defaultRadius)))
                    : null,
                pressElevation: 3,
                selectedColor:
                    Theme.of(context).unknownWordColor.withOpacity(0.6),
                backgroundColor:
                    Theme.of(context).unknownWordColor.withOpacity(0.2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0),
                visualDensity:
                    const VisualDensity(horizontal: 0.0, vertical: 0),
                label: Text(
                  translations[index].text,
                  softWrap: true,
                  maxLines: 10000,
                ),
                selected: translations[index].selected,
                onSelected: widget.changeable
                    ? (bool selected) {
                        setState(() {
                          translations[index].selected =
                              !translations[index].selected;
                          translations[index].selectionDate =
                              selected ? DateTime.now() : null;
                        });
                      }
                    : (_) => {},
              );
            },
          ).toList(),
        ),
        translations.first.source == googleSource
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultMargin),
                child: SvgPicture.asset(
                  translatedByGoogleSvg,
                ),
              )
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
