import 'package:freader/objectbox.g.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:path_provider/path_provider.dart';

class DBControllerFactory {
  Future<DBController> getDBController() async {
    final dir = await getApplicationDocumentsDirectory();
    final store =
        Store(getObjectBoxModel(), directory: "${dir.path}/objectbox2");

    return DBController(store);
  }
}
