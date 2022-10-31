import 'package:flutter/material.dart';
import 'package:freader/models/book.dart';

import 'reader_screen.dart';

class ReaderPage extends StatefulWidget {
  final Book book;

  const ReaderPage({super.key, required this.book});

  @override
  // ignore: library_private_types_in_public_api
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReaderScreen(
        chapter: widget.book.chapters[3],
      ),
    );
  }
}
