import 'package:freader/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LearnCardType extends StatefulWidget {
  final String source;
  final List<String> translations;
  final VoidCallback submitted;

  const LearnCardType(
      {super.key,
      required this.source,
      required this.translations,
      required this.submitted});

  @override
  State<LearnCardType> createState() => _LearnCardTypeState();
}

class _LearnCardTypeState extends State<LearnCardType> {
  final TextEditingController _textEditingController = TextEditingController();

  int remainingTries = 3;

  void _helpHandler() {
    var value = _textEditingController.text.trim().toLowerCase();

    while (true) {
      if (value.isEmpty) {
        _textEditingController.text = widget.translations.first[0];
        _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length));
        return;
      }

      for (var element in widget.translations) {
        if (element.startsWith(value)) {
          if (element == value) {
            widget.submitted();
          } else {
            _textEditingController.text = value + element[value.length];
            _textEditingController.selection = TextSelection.fromPosition(
                TextPosition(offset: _textEditingController.text.length));
          }
          return;
        }
      }
      value = value.substring(0, value.length - 1);
    }
  }

  void _fieldSubmittedHandler(String value) {
    setState(() {
      remainingTries--;
      value = value.trim().toLowerCase();
      if (remainingTries == 0 ||
          widget.translations
              .any((element) => element.trim().toLowerCase() == value)) {
        widget.submitted();
      }
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: double.maxFinite,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(doubleDefaultMargin),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                child: AutoSizeText(
                  widget.source,
                  maxLines: widget.source.contains(" ") ? null : 1,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  child: TextFormFieldDefault(
                    controller: _textEditingController,
                    onFieldSubmitted: _fieldSubmittedHandler,
                    labelText: 'Type here',
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultMargin),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.help_outline_rounded),
                      onPressed: _helpHandler,
                    ),
                    const SizedBox(
                      width: doubleDefaultMargin,
                    ),
                    Expanded(
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultRadius / 2),
                        ),
                        onTap: () {
                          _fieldSubmittedHandler(_textEditingController.text);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .unknownWordColor
                                    .withOpacity(0.7),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(defaultRadius / 2)),
                              ),
                              padding: const EdgeInsets.all(defaultMargin),
                              child: const Center(
                                child: Text(
                                  "Check",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: darkGray,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 4,
                                right: 4,
                                child: Text(remainingTries.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                        height: 1)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: doubleDefaultMargin,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
