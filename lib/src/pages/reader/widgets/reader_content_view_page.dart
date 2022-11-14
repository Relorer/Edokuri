import 'package:flutter/material.dart';
import 'package:freader/src/core/utils/string_utils.dart';
import 'package:freader/src/pages/reader/widgets/known_word.dart';
import 'package:freader/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:freader/src/theme/theme.dart';

class ReaderContentViewPage extends StatelessWidget {
  final String content;

  const ReaderContentViewPage({Key? key, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paragraphs = getParagraphs(content);

    return SizedBox(
      width: double.maxFinite,
      child: SelectableText.rich(
        TextSpan(
            style: Theme.of(context).readerPageTextStyle,
            children: paragraphs
                .map((p) => TextSpan(
                      children: [
                        ...p.pieces.map((e) => e.isWord
                            ? TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: KnownWord(
                                    word: e,
                                    onTap: () =>
                                        TapOnWordHandlerProvider.of(context)
                                            .tapOnWordHandler(e.content),
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
