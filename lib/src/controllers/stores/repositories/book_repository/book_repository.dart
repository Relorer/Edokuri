// 🎯 Dart imports:
import 'dart:developer';
import 'dart:typed_data';

// 🐦 Flutter imports:
import 'package:flutter/services.dart' show rootBundle;

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/cache_controller/cache_controller.dart';
import 'package:edokuri/src/controllers/common/date_controller/date_controller.dart';
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/utils/string_utils.dart';
import 'package:edokuri/src/models/models.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

const _book = "book";

abstract class BookRepositoryBase with Store {
  final PocketbaseController pb;
  final CacheController cacheController = CacheController();
  final DateController dateController = getIt<DateController>();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.pb) {
    isLoading = true;
    pb.client.collection(_book).getFullList().then((value) async {
      try {
        for (var record in value) {
          books.add(await getBookFromRecord(record));
        }
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
      }
      isLoading = false;
      pb.client.collection(_book).subscribe("*", (e) async {
        try {
          if (e.record == null) return;
          if (e.action == "delete") {
            pb.removeFile(e.record!, "chapters");
            pb.removeFile(e.record!, "words");
            pb.removeFile(e.record!, "cover");
            books.removeWhere((element) => element.id == e.record!.id);
          } else if (e.action == "create") {
            isLoading = true;
            books.add(await getBookFromRecord(e.record!));
            isLoading = false;
          } else {
            final newBook = Book.fromRecord(e.record!);
            final booksWithId =
                books.where((element) => element.id == newBook.id);
            if (booksWithId.isEmpty) {
              isLoading = true;
              books.add(await getBookFromRecord(e.record!));
              isLoading = false;
              return;
            } else {
              final book = booksWithId.first;
              book.author = newBook.author;
              book.currentChapter = newBook.currentChapter;
              book.currentCompletedChapter = newBook.currentCompletedChapter;
              book.currentCompletedPositionInChapter =
                  newBook.currentCompletedPositionInChapter;
              book.currentPositionInChapter = newBook.currentPositionInChapter;
              book.readTimes = book.readTimes;
              book.title = book.title;
              book.updated = book.updated;
              books.replaceRange(0, 1, [books.first]);
            }
          }
        } catch (e, stacktrace) {
          log("${e.toString()}\n${stacktrace.toString()}");
        }
      });

      // add default book
      rootBundle.load("assets/books/alice.epub").then((value) async {
        final user = getIt<PocketbaseController>().user;
        if (user == null ||
            user.created.isBefore(
                dateController.now().subtract(const Duration(minutes: 4))) ||
            books.any((element) =>
                element.title == "Alice's Adventures in Wonderland")) {
          return;
        }
        await getIt<FileController>().addBookFile(value.buffer.asUint8List());
      });
    });
  }

  void dispose() async {
    try {
      await pb.client.collection(_book).unsubscribe("*");
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future<Book> getBookFromRecord(RecordModel record) async {
    final book = Book.fromRecord(record);

    final chapters = await pb.getFile(record, "chapters");
    if (chapters.isNotEmpty) {
      book.chapters.addAll(decodeFile(chapters));
    } else {
      book.chapters.add("Not found");
    }
    final words = await pb.getFile(record, "words");
    if (words.isNotEmpty) {
      book.words.addAll(decodeFile(words));
    }

    final cover = await pb.getFile(record, "cover");
    if (cover.isNotEmpty) {
      book.cover = Uint8List.fromList(cover);
    }

    return book;
  }

  Future updateBookCover(Book book) async {
    try {
      final recordModel = await pb.client.collection(_book).getOne(book.id);
      await pb.removeFile(recordModel, "cover");
      final files = [
        http.MultipartFile.fromBytes(
          'cover',
          book.cover!,
          filename: 'cover',
        )
      ];
      await pb.client.collection(_book).update(book.id, files: files);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future resetProgress(Book book) async {
    try {
      final body = {
        "currentChapter": 0,
        "currentCompletedChapter": 0,
        "currentPositionInChapter": 0,
        "currentCompletedPositionInChapter": 0,
        "lastReading": DateTime(0).toIso8601String(),
      };
      await pb.client.collection(_book).update(book.id, body: body);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future putBook(Book book) async {
    try {
      final body = book.toJson()..["user"] = pb.user?.id;

      if (book.id.isEmpty) {
        final chapters = encodeFile(book.chapters);
        final words = encodeFile(book.words);

        final files = [
          http.MultipartFile.fromBytes(
            'chapters',
            chapters,
            filename: 'chapters',
          ),
          http.MultipartFile.fromBytes(
            'words',
            words,
            filename: 'words',
          ),
        ];
        if (book.cover != null) {
          files.add(http.MultipartFile.fromBytes(
            'cover',
            book.cover!,
            filename: 'cover',
          ));
        }
        final result =
            await pb.client.collection(_book).create(body: body, files: files);
        //TODO
        await pb.putFile(result, "chapters", chapters);
        await pb.putFile(result, "words", words);
        await pb.putFile(result, "cover", book.cover!);
      } else {
        await pb.client.collection(_book).update(book.id, body: body);
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future removeBook(Book book) async {
    try {
      final recordModel = await pb.client.collection(_book).getOne(book.id);
      await pb.removeFile(recordModel, "chapters");
      await pb.removeFile(recordModel, "words");
      await pb.removeFile(recordModel, "cover");
      await pb.client.collection(_book).delete(book.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
