import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class SetRecords {
  int id;
  final user = ToOne<User>();

  String name;

  final records = ToMany<Record>();

  SetRecords({this.id = 0, required this.name});
}
