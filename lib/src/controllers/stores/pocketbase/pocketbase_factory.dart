// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';

class PocketBaseFactory {
  Future<PocketbaseController> getPB() async {
    final pb = PocketbaseController();
    await pb.load();
    return pb;
  }
}
