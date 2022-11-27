import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/set.dart';

class SetData {
  final SetRecords? set;

  List<Record> records;

  SetData(this.records, {this.set});
}
