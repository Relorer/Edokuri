import 'package:freader/src/models/record.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Set {
  int id;

  final words = ToMany<Record>();

  Set({
    this.id = 0,
  });
}
