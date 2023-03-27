// 📦 Package imports:
import 'dart:typed_data';

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

  User({this.name = "", this.id = "", this.email = ""});

  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
