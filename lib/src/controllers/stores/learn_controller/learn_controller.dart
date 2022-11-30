import 'package:freader/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'learn_controller.g.dart';

class LearnController = LearnControllerBase with _$LearnController;

abstract class LearnControllerBase with Store {
  final RecordRepository recordRepository;
  final List<Record> records;

  LearnControllerBase(this.recordRepository, this.records);

  @observable
  int currentRecord = 0;
}
