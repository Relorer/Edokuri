import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
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

  void _translate(BuildContext context, Piece piece, int index) {
    final indexOnPage = content.indexOf(piece.content, index);
    if (indexOnPage > -1) {
      final sentence =
          context.read<ReaderController>().getSentence(indexOnPage);
      TapOnWordHandlerProvider.of(context)
          .tapOnWordHandler(piece.content, sentence);
    } else {
      TapOnWordHandlerProvider.of(context).tapOnWordHandler(piece.content, "");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tapOnWordHandler =
        TapOnWordHandlerProvider.of(context).tapOnWordHandler;

    final paragraphs = getParagraphs(content);

    final List<InlineSpan> textSpans = [];
    final List<String> piecesOfPage = [];

    int currentIndex = 0;

    for (var paragraph in paragraphs) {
      for (var piece in paragraph.pieces) {
        int tempCurrentIndex = currentIndex;
        textSpans.add(piece.isWord
            ? WidgetSpan(
                child: Observer(
                builder: (context) => getWord(
                    context.read<RecordRepository>().getRecord(piece.content),
                    piece,
                    () => _translate(context, piece, tempCurrentIndex)),
              ))
            : TextSpan(
                text: piece.content,
              ));

        if (piece.isWord) {
          piecesOfPage.add(piece.content);
        } else {
          piecesOfPage.addAll(piece.content.split(""));
        }

        currentIndex += piece.content.length;
      }

      if (paragraphs.indexOf(paragraph) < paragraphs.length - 2) {
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
          handleTranslate: ((text) => tapOnWordHandler(text, "")),
          canTranslate: containsWord,
        ),
        TextSpan(
            style: Theme.of(context).readerPageTextStyle, children: textSpans),
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
