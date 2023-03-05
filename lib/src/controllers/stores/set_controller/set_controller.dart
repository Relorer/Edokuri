import 'package:freader/src/models/models.dart';
import 'package:freader/src/models/record.dart';

class SetData {
  final SetRecords? set;

  List<Record> records;

  SetData(this.records, {this.set});
}
