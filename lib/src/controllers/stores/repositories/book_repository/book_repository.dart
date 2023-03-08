// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/core/utils/datetime_extensions.dart';
import 'package:edokuri/src/models/models.dart';

part 'book_repository.g.dart';

class BookRepository = BookRepositoryBase with _$BookRepository;

abstract class BookRepositoryBase with Store {
  final PocketbaseController pb;
  final UserRepository userRepository;

  ObservableList<Book> books = ObservableList<Book>.of([]);

  BookRepositoryBase(this.pb, this.userRepository) {}

  void putBook(Book book) {
    try {
      final body = book.toJson()..["user"] = pb.user?.id;
      if (book.id.isEmpty) {
        pb.client.collection("book").create(body: body);
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  void removeBook(Book book) {}

  int readingTimeForTodayInMinutes() {
    final today = DateTime.now();
    final readingTimesForToday = books
        .expand((element) => element.readTimes)
        .where((element) => element.start.isSameDate(today))
        .map((e) =>
            e.end.millisecondsSinceEpoch - e.start.millisecondsSinceEpoch);

    final readingTimeForToday = readingTimesForToday.isEmpty
        ? 0
        : readingTimesForToday.reduce((t1, t2) => t1 + t2);

    return readingTimeForToday / 1000 ~/ 60;
  }
}
