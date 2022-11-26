import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/set.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;

  @Backlink('user')
  final books = ToMany<Record>();

  @Backlink('user')
  final records = ToMany<Record>();

  @Backlink('user')
  final sets = ToMany<SetRecords>();

  User({
    this.id = 0,
  });
}
