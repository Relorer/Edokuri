import 'package:freader/src/models/models.dart';
import 'package:freader/objectbox.g.dart' as box;
import 'package:mobx/mobx.dart';

part 'user_repository.g.dart';

class UserRepository = UserRepositoryBase with _$UserRepository;

abstract class UserRepositoryBase with Store {
  final box.Store store;
  late User currentUser;

  UserRepositoryBase(this.store) {
    final userBox = store.box<User>();

    final temp = userBox.getAll();
    if (temp.isEmpty) {
      currentUser = User();
      currentUser.id = userBox.put(currentUser);
    } else {
      currentUser = temp.first;
    }
  }
}
