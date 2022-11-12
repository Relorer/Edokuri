import 'package:flutter/material.dart';
import 'package:freader/src/models/book.dart';
import 'word_widget.dart';

class ReaderPageWidget extends StatelessWidget {
  final String content;

  const ReaderPageWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paragraphs = getParagraphs(content);

    return SizedBox(
      width: double.maxFinite,
      child: SelectableText.rich(
        TextSpan(
            style: const TextStyle(
                fontSize: 18, wordSpacing: 2, height: 1.6, color: Colors.black),
            children: paragraphs
                .map((p) => TextSpan(
                      children: [
                        ...p.pieces.map((e) => e.isWord
                            ? TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: WordWidget(
                                    word: e,
                                    onTap: () {},
                                  )),
                                ],
                              )
                            : TextSpan(
                                text: e.content,
                              )),
                        paragraphs.indexOf(p) < paragraphs.length - 1
                            ? const TextSpan(text: "\n")
                            : const TextSpan(),
                      ],
                    ))
                .toList()),
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
