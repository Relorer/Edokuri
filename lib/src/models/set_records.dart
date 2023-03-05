import 'package:freader/src/models/record.dart';

class SetRecords {
  String name;
  List<Record> records = [];
  List<String> recordIds;

  SetRecords(this.name, {this.recordIds = const []});

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'recordIds': recordIds,
    };
  }

  static SetRecords fromJson(Map<String, Object> json) {
    return SetRecords(json['name'] as String,
        recordIds: json['name'] as List<String>);
  }
}
