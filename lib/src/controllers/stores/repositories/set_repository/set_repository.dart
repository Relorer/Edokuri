import 'dart:developer';

import 'package:freader/src/controllers/stores/appwrite/appwrite_controller.dart';
import 'package:freader/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:freader/src/models/models.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:mobx/mobx.dart';

part 'set_repository.g.dart';

class SetRepository = SetRepositoryBase with _$SetRepository;

abstract class SetRepositoryBase with Store {
  final String collectionId =
      FlutterConfig.get('APPWRITE_COLLECTION_SETRECORDS');

  final AppwriteController appwrite;
  final UserRepository userRepository;

  ObservableList<SetRecords> sets = ObservableList<SetRecords>.of([]);

  SetRepositoryBase(this.appwrite, this.userRepository) {
    getSets();
  }

  @action
  void setNewList(List<SetRecords> newSets) {
    sets.clear();
    sets.addAll(newSets);
  }

  void getSets() {
    appwrite.realtime
        .subscribe(["collections.[$collectionId]"])
        .stream
        .listen((event) {
          log(event.payload.toString());
        });
  }

  void putSet(SetRecords set) {
    // set.user.target = userRepository.currentUser;
    // store.box<SetRecords>().put(set);
  }

  void removeSet(SetRecords set) {
    // store.box<SetRecords>().remove(set.id);
  }
}
