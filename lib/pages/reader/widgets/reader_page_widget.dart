import 'package:flutter/material.dart';
import 'package:freader/Services/epub_service.dart';
import 'word_widget.dart';

class ReaderPageWidget extends StatelessWidget {
  final String content;

  const ReaderPageWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(
              fontSize: 18, wordSpacing: 2, height: 1.6, color: Colors.black),
          children: EpubService.getParagraphs(content)
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
                      const TextSpan(text: "\n"),
                    ],
                  ))
              .toList()),
    );
  }
}
