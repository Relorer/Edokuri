import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/core/button_with_icon.dart';
import 'package:freader/src/models/book.dart';
import 'package:freader/src/pages/reader/reader_page.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';

class BookCardWidget extends StatelessWidget {
  final Book book;

  const BookCardWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _openBook() {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => ReaderPage(book: book),
            ),
          )
          .then((value) =>
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Theme.of(context).secondBackgroundColor,
                statusBarColor: Theme.of(context).secondBackgroundColor,
                statusBarIconBrightness: Brightness.light,
              )));
    }

    _removeBook() {
      ProviderDbController.ctr(context).removeBook(book);
      Navigator.pop(context);
    }

    return Card(
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        highlightColor: Theme.of(context).secondBackgroundColor.withAlpha(40),
        splashColor: Theme.of(context).secondBackgroundColor.withAlpha(30),
        onTap: _openBook,
        onLongPress: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Container(
                  color: Theme.of(context).secondBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          book.title,
                          style: Theme.of(context).dialogTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonWithIcon(
                          text: "Continue reading",
                          onTap: _openBook,
                          svg: readingSvg,
                        ),
                        ButtonWithIcon(
                          text: "Go to Set",
                          svg: goToSetSvg,
                          onTap: _openBook,
                        ),
                        ButtonWithIcon(
                          text: "Delete",
                          svg: deleteSvg,
                          onTap: _removeBook,
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: SizedBox(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            book.cover != null
                ? Ink.image(
                    height: 110,
                    width: 70,
                    fit: BoxFit.fitHeight,
                    image: MemoryImage(book.cover!))
                : Container(
                    height: 110,
                    width: 70,
                    color: Theme.of(context).paleElementColor,
                    child: const Center(
                        child: Text(
                      "cover",
                      style: TextStyle(color: Colors.white60),
                    )),
                  ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).bookTitleStyle,
                    ),
                    Text(
                      book.author,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).bookAuthorStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 4,
                        child: LinearProgressIndicator(
                          value: 0.35, // percent filled
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).progressBarActiveColor),
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Records: 145",
                          style: Theme.of(context).bookSubInfoStyle,
                        ),
                        Text(
                          "64% New words",
                          style: Theme.of(context).bookSubInfoStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
