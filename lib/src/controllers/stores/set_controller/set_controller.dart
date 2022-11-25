import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/set.dart';
import 'package:mobx/mobx.dart';

part 'set_controller.g.dart';

class SetController = SetControllerBase with _$SetController;

abstract class SetControllerBase with Store {
  final DBController db;
  final SetRecords? set;

  @observable
  List<Record> records;

  SetControllerBase(this.db, this.records, {this.set});
}
