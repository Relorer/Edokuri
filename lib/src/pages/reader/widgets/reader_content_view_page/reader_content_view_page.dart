// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/reader_controller/reader_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/iterable_extensions.dart';
import 'package:edokuri/src/core/utils/string_utils.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/form_word.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/known_word.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/part_of_record.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/reader_text_selection_controls.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/saved_word.dart';
import 'package:edokuri/src/pages/reader/widgets/reader_content_view_page/unknown_word.dart';
import 'package:edokuri/src/pages/reader/widgets/tap_on_word_handler_provider.dart';
import 'package:edokuri/src/theme/theme.dart';

class ReaderContentViewPage extends StatelessWidget {
  final String content;

  const ReaderContentViewPage({Key? key, required this.content})
      : super(key: key);

  Widget getWord(Piece word, List<Record> records, Function()? onTap) {
    final content = word.content.toLowerCase().trim();

    final recordsWithWord = records
        .where(
          (record) => isWholeWordInString(content, record.originalLowerCase),
        )
        .toList();

    final record = recordsWithWord.firstWhereOrNull(
      (record) => record.originalLowerCase == content,
    );

    if (record != null) {
      return SavedWord(
        word: word,
        onTap: onTap,
        reviewInterval: record.reviewInterval,
      );
    }

    final form = records.firstWhereOrNull(
        (p0) => p0.forms.any((element) => element == content));

    if (form != null) {
      return FormWord(
        word: word,
        onTap: onTap,
        reviewInterval: form.reviewInterval,
      );
    }

    if (getIt<KnownRecordsRepository>().exist(word.content)) {
      return KnownWord(
        word: word,
        onTap: onTap,
      );
    }

    if (recordsWithWord.isNotEmpty) {
      recordsWithWord
          .sort((a, b) => a.reviewInterval.compareTo(b.reviewInterval));
      return PartOfRecord(
          word: word,
          reviewInterval: recordsWithWord.first.reviewInterval,
          onTap: onTap);
    }

    return UnknownWord(
      word: word,
      onTap: onTap,
    );
  }

  void _translate(BuildContext context, String content, int index) {
    final indexOnPage = this.content.indexOf(content, index);
    if (indexOnPage > -1) {
      final sentence = context
          .read<ReaderController>()
          .getSentence(indexOnPage, content.length);
      TapOnWordHandlerProvider.of(context)
          .tapOnWordHandler(content.trim(), sentence);
    } else {
      TapOnWordHandlerProvider.of(context).tapOnWordHandler(content.trim(), "");
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
                    piece,
                    getIt<RecordRepository>().records,
                    () => _translate(context, piece.content, tempCurrentIndex)),
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
              ? piecesOfPage.sublist(p0.start, p0.end).join()
              : ""),
          handleTranslate: ((text, p0) {
            final index = piecesOfPage.sublist(0, p0.start).join().length - 1;
            _translate(context, text, index);
          }),
          canTranslate: containsWord,
        ),
        TextSpan(
            style: Theme.of(context).readerPageTextStyle, children: textSpans),
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
