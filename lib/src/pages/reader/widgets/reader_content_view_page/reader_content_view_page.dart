import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/string_utils.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view_page/known_word.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view_page/reader_text_selection_controls.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view_page/saved_word.dart';
import 'package:freader/src/pages/reader/widgets/reader_content_view_page/unknown_word.dart';
import 'package:freader/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:provider/provider.dart';

class ReaderContentViewPage extends StatelessWidget {
  final String content;

  const ReaderContentViewPage({Key? key, required this.content})
      : super(key: key);

  Widget getWord(Record? record, Piece word, Function()? onTap) {
    if (record == null) {
      return UnknownWord(
        word: word,
        onTap: onTap,
      );
    }
    if (record.known) {
      return KnownWord(
        word: word,
        onTap: onTap,
      );
    }
    return SavedWord(
      word: word,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tapOnWordHandler =
        TapOnWordHandlerProvider.of(context).tapOnWordHandler;

    final paragraphs = getParagraphs(content);

    final List<InlineSpan> textSpans = [];
    final List<String> piecesOfPage = [];

    for (var paragraph in paragraphs) {
      for (var piece in paragraph.pieces) {
        textSpans.add(piece.isWord
            ? WidgetSpan(
                child: Observer(
                builder: (context) => getWord(
                    context.read<DBController>().getRecord(piece.content),
                    piece,
                    () => tapOnWordHandler(piece.content)),
              ))
            : TextSpan(
                text: piece.content,
              ));

        if (piece.isWord) {
          piecesOfPage.add(piece.content);
        } else {
          piecesOfPage.addAll(piece.content.split(""));
        }
      }

      if (paragraphs.indexOf(paragraph) < paragraphs.length - 1) {
        textSpans.add(const TextSpan(text: "\n"));
        piecesOfPage.add("\n");
      }
    }

    return SizedBox(
      width: double.maxFinite,
      child: SelectableText.rich(
        selectionControls: ReaderTextSelectionControls(
          getSelectedText: ((p0) => piecesOfPage.length >= p0.start &&
                  piecesOfPage.length >= p0.end &&
                  p0.start > -1 &&
                  p0.end > -1
              ? piecesOfPage.sublist(p0.start, p0.end).join().trim()
              : ""),
          handleTranslate: tapOnWordHandler,
          canTranslate: containsWord,
        ),
        TextSpan(
            style: Theme.of(context).readerPageTextStyle, children: textSpans),
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
