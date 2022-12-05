import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freader/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:freader/src/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LearnCardType extends StatefulWidget {
  final String source;
  final List<String> translations;

  const LearnCardType(
      {super.key, required this.source, required this.translations});

  @override
  State<LearnCardType> createState() => _LearnCardTypeState();
}

class _LearnCardTypeState extends State<LearnCardType> {
  final TextEditingController _textEditingController = TextEditingController();

  void _fieldSubmittedHandler(String value) {
    setState(() {
      value = value.trim().toLowerCase();

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
                      onPressed: () => {},
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
                        onTap: () => {},
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
                            const Positioned(
                                top: 4,
                                right: 4,
                                child: Text("3",
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
