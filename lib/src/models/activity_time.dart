import 'package:objectbox/objectbox.dart';

@Entity()
class ActivityTime {
  int id;
  final DateTime start;
  final DateTime end;

  int get timespan => end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

  ActivityTime(
    this.start,
    this.end, {
    this.id = 0,
  });
}
