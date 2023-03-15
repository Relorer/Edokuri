// 🎯 Dart imports:
import 'dart:convert';
import 'dart:developer';

// 📦 Package imports:
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/cache_controller/cache_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';

part 'pocketbase_controller.g.dart';

class PocketbaseController = PocketbaseControllerBase
    with _$PocketbaseController;

final pocketbaseUrl = FlutterConfig.get("POCKETBASE_URL");
final redirectUri = "$pocketbaseUrl/auth-redirect";
const callbackUrlScheme = "https";
const authTokenKey = "auth_token_key";

abstract class PocketbaseControllerBase with Store {
  final secureStorage = getIt<FlutterSecureStorage>();
  final CacheController cacheController = CacheController();
  final client = PocketBase(pocketbaseUrl);
  User? user;

  @observable
  bool isAuthorized = false;

  PocketbaseControllerBase() {
    client.authStore.onChange.listen((e) async {
      final encoded = jsonEncode(<String, dynamic>{
        "token": e.token,
        "model": e.model,
      });

      if (client.authStore.model != null) {
        user = User.fromRecord(client.authStore.model);
        await setupRepositoryScope(user!.id);
      } else {
        user = null;
      }

      isAuthorized = client.authStore.token.isNotEmpty;
      secureStorage.write(key: authTokenKey, value: encoded);
    });
  }

  Future load() async {
    final String? raw = await secureStorage.read(key: authTokenKey);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      final token = (decoded as Map<String, dynamic>)["token"] as String? ?? "";
      final model =
          RecordModel.fromJson(decoded["model"] as Map<String, dynamic>? ?? {});
      if (token.isNotEmpty) {
        client.authStore.save(token, model);
        await client.collection("users").authRefresh();
      }
    }
  }

  @action
  Future googleAuth() async {
    await _authWithProvider("google");
  }

  @action
  Future githubAuth() async {
    await _authWithProvider("github");
  }

  @action
  Future skipAuth() async {
    try {
      final username = const Uuid().v4().replaceAll('-', '');
      final pass = const Uuid().v4();
      await client.collection('users').create(body: {
        "username": username,
        "password": pass,
        "passwordConfirm": pass,
      });
      await client.collection('users').authWithPassword(username, pass);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  @action
  Future logout() async {
    client.authStore.clear();
  }

  Uri getFileUrl(RecordModel record, String field) {
    final fileName = record.getListValue<String>(field)[0];
    return client.getFileUrl(record, fileName);
  }

  Future<List<int>> getFile(RecordModel record, String field) async {
    try {
      final fileUrl = getFileUrl(record, field);
      final cache = await cacheController.getFile(fileUrl.toString());
      if (cache == null) {
        final file = await http.readBytes(fileUrl.normalizePath());
        await cacheController.putFile(file, fileUrl.toString());
        return file;
      }
      return cache;
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
    return [];
  }

  Future putFile(RecordModel record, String field, List<int> bytes) async {
    try {
      cacheController.putFile(bytes, getFileUrl(record, field).toString());
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future removeFile(RecordModel record, String field) async {
    try {
      cacheController.removeFile(getFileUrl(record, field).toString());
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future _authWithProvider(String providerName) async {
    try {
      final authMethods = await client.collection("users").listAuthMethods();
      final provider = authMethods.authProviders
          .where((am) => am.name.toLowerCase() == providerName)
          .first;
      final responseUrl = await FlutterWebAuth.authenticate(
          url: "${provider.authUrl}$redirectUri",
          callbackUrlScheme: callbackUrlScheme);
      final parsedUri = Uri.parse(responseUrl);
      final code = parsedUri.queryParameters['code']!;
      await client.collection("users").authWithOAuth2(
          providerName, code, provider.codeVerifier, redirectUri);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }
}
