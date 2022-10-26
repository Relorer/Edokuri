import 'package:flutter/material.dart';
import 'package:freader/widgets/reader/reader_widget.dart';
import '../models/book.dart';

class ReaderPage extends StatefulWidget {
  final Book book;

  const ReaderPage({super.key, required this.book});

  @override
  // ignore: library_private_types_in_public_api
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reader'),
        ),
        body: ReaderWidget(
          book: widget.book,
        ));
  }
}
