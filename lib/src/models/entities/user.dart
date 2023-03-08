// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

// Project imports:
import 'package:edokuri/src/models/models.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String user;

  String name;
  List<Book> books;
  List<Record> records;
  List<SetRecords> sets;
  List<ActivityTime> learnTimes;
  List<TimeMark> streak;

  User(
      {this.name = "",
      this.id = "",
      this.books = const [],
      this.learnTimes = const [],
      this.records = const [],
      this.sets = const [],
      this.streak = const [],
      this.user = ""});

  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
