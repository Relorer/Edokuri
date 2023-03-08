import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'set_repository.g.dart';

class SetRepository = SetRepositoryBase with _$SetRepository;

abstract class SetRepositoryBase with Store {
  final PocketbaseController pb;
  final UserRepository userRepository;

  ObservableList<SetRecords> sets = ObservableList<SetRecords>.of([]);

  SetRepositoryBase(this.pb, this.userRepository) {}

  @action
  void setNewList(List<SetRecords> newSets) {
    sets.clear();
    sets.addAll(newSets);
  }

  Stream<List<SetRecords>> getSets() {
    return Stream.empty();
  }

  void putSet(SetRecords set) {}

  void removeSet(SetRecords set) {}
}
