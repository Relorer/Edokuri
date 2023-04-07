// 🎯 Dart imports:
import 'dart:typed_data';

// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

// 🌎 Project imports:

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;

  String name;
  String email;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? avatar;
  DateTime created;

  User({this.name = "", this.id = "", this.email = "", required this.created});

  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
