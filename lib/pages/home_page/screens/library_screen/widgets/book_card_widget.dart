import 'package:flutter/material.dart';
import 'package:freader/models/book.dart';
import 'package:freader/pages/reader/reader_page.dart';
import 'package:freader/theme.dart';

class BookCardWidget extends StatelessWidget {
  final Book book;

  const BookCardWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        highlightColor: Theme.of(context).secondBackgroundColor.withAlpha(40),
        splashColor: Theme.of(context).secondBackgroundColor.withAlpha(30),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReaderPage(book: book),
            ),
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
                : Container(),
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
                      child: Container(
                        height: 4,
                        child: LinearProgressIndicator(
                          value: 0.35, // percent filled
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).progressBarActiveColor),
                          backgroundColor: Theme.of(context).backgroundColor,
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
