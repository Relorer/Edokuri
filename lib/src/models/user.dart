import 'package:freader/src/models/record.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;

  final records = ToMany<Record>();
  final sets = ToMany<Record>();

  User({
    this.id = 0,
  });
}
