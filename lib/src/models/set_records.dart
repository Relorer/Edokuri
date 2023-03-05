import 'package:freader/src/models/record.dart';

class SetRecords {
  String id;
  String name;
  List<Record> records = [];
  List<String> recordIds;

  SetRecords(this.name, {this.recordIds = const [], this.id = ""});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'recordIds': recordIds,
    };
  }

  static SetRecords fromJson(Map<String, dynamic> json) {
    return SetRecords(json['name'] as String,
        recordIds: json['name'] as List<String>, id: json['id'] as String);
  }
}
