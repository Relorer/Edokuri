// 🎯 Dart imports:
import 'dart:developer';
import 'dart:typed_data';

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/cache_controller/cache_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/utils/string_utils.dart';
import 'package:edokuri/src/models/models.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

const _book = "book";

abstract class BookRepositoryBase with Store {
  final PocketbaseController pb;
  final CacheController cacheController = CacheController();

  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.pb) {
    pb.client.collection(_book).getFullList().then((value) async {
      try {
        for (var record in value) {
          books.add(await getBookFromRecord(record));
        }
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
      }
      pb.client.collection(_book).subscribe("*", (e) async {
        try {
          if (e.record == null) return;
          books.removeWhere((element) => element.id == e.record!.id);
          if (e.action == "delete") {
            pb.removeFile(e.record!, "chapters");
            pb.removeFile(e.record!, "words");
            pb.removeFile(e.record!, "cover");
          }
          if (e.action == "update" || e.action == "create") {
            books.add(await getBookFromRecord(e.record!));
          }
        } catch (e, stacktrace) {
          log("${e.toString()}\n${stacktrace.toString()}");
        }
      });
    });
  }

  Future<Book> getBookFromRecord(RecordModel record) async {
    final book = Book.fromRecord(record);
    book.chapters.addAll(decodeFile(await pb.getFile(record, "chapters")));
    book.words.addAll(decodeFile(await pb.getFile(record, "words")));
    book.cover = Uint8List.fromList((await pb.getFile(record, "cover")));
    return book;
  }

  void putBook(Book book) async {
    try {
      final body = book.toJson()..["user"] = pb.user?.id;

      if (book.id.isEmpty) {
        final chapters = encodeFile(book.chapters);
        final words = encodeFile(book.words);

        final files = [
          http.MultipartFile.fromBytes(
            'chapters', // the name of the file field
            chapters,
            filename: 'chapters',
          ),
          http.MultipartFile.fromBytes(
            'words', // the name of the file field
            words,
            filename: 'words',
          ),
        ];
        if (book.cover != null) {
          files.add(http.MultipartFile.fromBytes(
            'cover', // the name of the file field
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
      await pb.client.collection(_book).delete(book.id);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
