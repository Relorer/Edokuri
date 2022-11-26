import 'package:freader/src/models/record.dart';
import 'package:freader/src/models/set.dart';
import 'package:mobx/mobx.dart';

part 'set_controller.g.dart';

class SetController = SetControllerBase with _$SetController;

abstract class SetControllerBase with Store {
  final SetRecords? set;

  @observable
  List<Record> records;

  SetControllerBase(this.records, {this.set});
}
