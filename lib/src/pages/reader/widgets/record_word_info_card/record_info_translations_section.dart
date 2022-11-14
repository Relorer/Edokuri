import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoTranslationsSection extends StatefulWidget {
  final List<String> translations;

  const RecordInfoTranslationsSection({super.key, required this.translations});

  @override
  State<RecordInfoTranslationsSection> createState() =>
      _RecordInfoTranslationsSectionState();
}

class _RecordInfoTranslationsSectionState
    extends State<RecordInfoTranslationsSection> {
  @override
  Widget build(BuildContext context) {
    final translations = widget.translations;

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
                backgroundColor:
                    Theme.of(context).unknownWordColor.withOpacity(0.6),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity(horizontal: 0.0, vertical: -2),
                label: Text(translations[index]),
                selected: false,
                onSelected: (bool selected) {
                  setState(() {
                    // _value = selected ? index : null;
                  });
                },
              );
            },
          ).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: defaultMargin),
          child: TextFormField(
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).unknownWordColor.withOpacity(0.6),
                    width: 0.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).unknownWordColor.withOpacity(0.6),
                    width: 0.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'Enter your translate',
            ),
          ),
        )
      ],
    );
  }
}
