import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/core/utils/datetime_extensions.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

abstract class BookRepositoryBase with Store {
  final AppwriteController appwrite;

  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.appwrite) {
    // getBooks(store).forEach(setNewList);
  }

  // @action
  // void setNewList(List<Book> newBooks) {
  //   books.clear();
  //   books.addAll(newBooks);
  // }

  // Stream<List<Book>> getBooks(box.Store store) {
  //   final query = store
  //       .box<Book>()
  //       .query(box.Book_.user.equals(userRepository.currentUser.id));
  //   return query
  //       .watch(triggerImmediately: true)
  //       .map<List<Book>>((query) => query.find());
  // }

  void putBook(Book book) async {
    try {
      // List<int> byteArray = Uint8List.fromList(json
      //         .encode(book.chapters.map((element) => element.content).toList())
      //         .codeUnits)
      //     .toList();
      // log(book.chapters
      //     .map((element) => element.content)
      //     .toList()
      //     .length
      //     .toString());
      // log(byteArray.length.toString());

      // final file =
      //     InputFile(filename: "test", contentType: "txt", bytes: byteArray);
      // await appwrite.storage.createFile(
      //     bucketId: FlutterConfig.get('APPWRITE_STORAGE_BOOKS'),
      //     fileId: ID.unique(),
      //     file: file);

      // await appwrite.databases.deleteDocument(
      //     databaseId:  FlutterConfig.get('APPWRITE_DATABASE_EDOKURI'),
      //     collectionId:  FlutterConfig.get('APPWRITE_COLLECTION_BOOKS'),
      //     documentId:  FlutterConfig.get('APPWRITE_API_ENDPOINT'));
      // var res = await appwrite.databases.createDocument(
      //     databaseId: "6400a8b022073c10544c",
      //     collectionId: "640362735db638224432",
      //     documentId: ID.unique(),
      //     data: book.toJson());
      // log(res.data.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  // void removeBook(Book book) {
  //   store.box<Book>().remove(book.id);
  // }

  // int readingTimeForTodayInMinutes() {
  //   final today = DateTime.now();
  //   final readingTimesForToday = books
  //       .expand((element) => element.readTimes)
  //       .where((element) => element.start.isSameDate(today))
  //       .map((e) =>
  //           e.end.millisecondsSinceEpoch - e.start.millisecondsSinceEpoch);

  //   final readingTimeForToday = readingTimesForToday.isEmpty
  //       ? 0
  //       : readingTimesForToday.reduce((t1, t2) => t1 + t2);

  //   return readingTimeForToday / 1000 ~/ 60;
  // }
}
