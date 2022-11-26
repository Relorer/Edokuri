import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/objectbox.g.dart' as box;
import 'package:freader/src/models/models.dart';
import 'package:mobx/mobx.dart';

part 'set_repository.g.dart';

class SetRepository = SetRepositoryBase with _$SetRepository;

abstract class SetRepositoryBase with Store {
  final box.Store store;
  final UserRepository userRepository;

  ObservableList<SetRecords> sets = ObservableList<SetRecords>.of([]);

  SetRepositoryBase(this.store, this.userRepository) {
    getSets(store).forEach((setsNewList) {
      sets.clear();
      sets.addAll(setsNewList);
    });
  }

  Stream<List<SetRecords>> getSets(box.Store store) {
    final query = store
        .box<SetRecords>()
        .query(box.SetRecords_.user.equals(userRepository.currentUser.id));
    return query
        .watch(triggerImmediately: true)
        .map<List<SetRecords>>((query) => query.find());
  }

  void putSet(SetRecords set) {
    set.user.target = userRepository.currentUser;
    store.box<SetRecords>().put(set);
  }

  void removeSet(SetRecords set) {
    store.box<SetRecords>().remove(set.id);
  }
}
