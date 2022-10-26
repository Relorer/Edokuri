import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/widgets/reader/chapter_reader_widget.dart';
import '../../models/book.dart';
import '../../models/book_indexes.dart';
import 'word_widget.dart';

class ReaderWidget extends StatefulWidget {
  final Book book;

  const ReaderWidget({super.key, required this.book});

  @override
  // ignore: library_private_types_in_public_api
  _ReaderWidgetState createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  @override
  Widget build(BuildContext context) {
    return ChapterReaderWidget(chapter: widget.book.chapters[3]);
  }
}
