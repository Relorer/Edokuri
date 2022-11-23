import 'package:freader/src/models/record.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class SetRecords {
  int id;

  String name;
  final records = ToMany<Record>();

  SetRecords({this.id = 0, required this.name});
}
