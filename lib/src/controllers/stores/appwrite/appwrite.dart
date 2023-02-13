import 'package:flutter_config/flutter_config.dart';
import 'package:appwrite/appwrite.dart';

class Appwrite {
  final Client client = Client();

  Appwrite() {
    client
        .setEndpoint(FlutterConfig.get('APPWRITE_API_ENDPOINT')!)
        .setProject(FlutterConfig.get('APPWRITE_PROJECT_ID')!)
        .setSelfSigned(
            status:
                true); // For self signed certificates, only use for development
  }
}
