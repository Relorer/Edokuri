import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:freader/src/controllers/common/cache_controller/cache_controller.dart';
import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

abstract class BookRepositoryBase with Store {
  final String collectionId = FlutterConfig.get('APPWRITE_COLLECTION_BOOKS');
  final String storageId = FlutterConfig.get('APPWRITE_STORAGE_BOOKS');

  final UserRepository userRepository;
  final AppwriteController appwrite;
  final CacheController cache;

  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.appwrite, this.userRepository, this.cache) {
    getBooks();
  }

  @action
  void setNewList(List<Book> newBooks) {
    books.clear();
    books.addAll(newBooks);
  }

  void getBooks() async {
    books.addAll((await appwrite.databases.listDocuments(
            databaseId: appwrite.databaseId, collectionId: collectionId))
        .documents
        .map((e) => Book.fromJson(e.data)));

    log(books.length.toString());

    appwrite.realtime
        .subscribe([
          "databases.${appwrite.databaseId}.collections.$collectionId.documents"
        ])
        .stream
        .listen((event) {
          log("test");
        });
  }

  void putBook(Book book) async {
    Document? res;
    try {
      book.id = ID.unique();
      book.fileId = ID.unique();

      res = await appwrite.databases.createDocument(
          databaseId: appwrite.databaseId,
          collectionId: collectionId,
          documentId: book.id,
          data: book.toJson());

      List<int> byteArray = json.encode(book.chapters).codeUnits;

      final file = InputFile(
          filename: book.title, contentType: "book", bytes: byteArray);

      await appwrite.storage
          .createFile(bucketId: storageId, fileId: book.fileId!, file: file);

      await cache.putFile(byteArray, book.fileId!);

      log(res.$id);
    } catch (e) {
      log(e.toString());
      if (res != null) {
        removeBook(book);
      }
    }
  }

  void removeBook(Book book) async {
    await appwrite.databases.deleteDocument(
        databaseId: appwrite.databaseId,
        collectionId: collectionId,
        documentId: book.id);
    await appwrite.storage
        .deleteFile(bucketId: storageId, fileId: book.fileId!);
    cache.removeFile(book.fileId!);
  }

  int readingTimeForTodayInMinutes() {
    // final today = DateTime.now();
    // final readingTimesForToday = books
    //     .expand((element) => element.readTimes)
    //     .where((element) => element.start.isSameDate(today))
    //     .map((e) =>
    //         e.end.millisecondsSinceEpoch - e.start.millisecondsSinceEpoch);

    // final readingTimeForToday = readingTimesForToday.isEmpty
    //     ? 0
    //     : readingTimesForToday.reduce((t1, t2) => t1 + t2);

    // return readingTimeForToday / 1000 ~/ 60;
    return 0;
  }
}
