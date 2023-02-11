import 'package:freader/src/models/activity_time.dart';
import 'package:freader/src/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;

  @Backlink('user')
  final books = ToMany<Book>();

  @Backlink('user')
  final records = ToMany<Record>();

  @Backlink('user')
  final sets = ToMany<SetRecords>();

  final learnTimes = ToMany<ActivityTime>();

  final streak = ToMany<TimeMark>();

  User({this.id = 0});
}

@Entity()
class TimeMark {
  int id;
  DateTime dateTime;

  TimeMark({
    this.id = 0,
    required this.dateTime,
  });
}
