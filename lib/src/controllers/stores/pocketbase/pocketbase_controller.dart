// 🎯 Dart imports:
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

// 📦 Package imports:
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:unique_names_generator/unique_names_generator.dart';
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
const passwordKey = "password_key";
const usernameKey = "username_key";

abstract class PocketbaseControllerBase with Store {
  final generator = UniqueNamesGenerator(
    config: Config(
        length: 2,
        seperator: ' ',
        style: Style.capital,
        dictionaries: [adjectives, animals]),
  );

  final secureStorage = getIt<FlutterSecureStorage>();
  final CacheController cacheController = CacheController();
  final client = PocketBase(pocketbaseUrl);
  User? user;

  @observable
  bool isAuthorized = false;

  @observable
  bool isLoading = false;

  PocketbaseControllerBase() {
    client.authStore.onChange.listen((e) async {
      isLoading = true;
      final encoded = jsonEncode(<String, dynamic>{
        "token": e.token,
        "model": e.model,
      });

      if (client.authStore.model != null) {
        user = User.fromRecord(client.authStore.model);
        final avatar =
            await getFile(client.authStore.model, "avatar", useCache: false);
        if (avatar.isNotEmpty) {
          user!.avatar = Uint8List.fromList(avatar);
        }
        await setupRepositoryScope(user!.id);
      } else {
        user = null;
      }

      isAuthorized = client.authStore.token.isNotEmpty;
      secureStorage.write(key: authTokenKey, value: encoded);
      isLoading = false;
    });
  }

  Future load() async {
    try {
      final String? raw = await secureStorage.read(key: authTokenKey);
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        final token =
            (decoded as Map<String, dynamic>)["token"] as String? ?? "";
        final model = RecordModel.fromJson(
            decoded["model"] as Map<String, dynamic>? ?? {});
        if (token.isNotEmpty) {
          client.authStore.save(token, model);
          await client.collection("users").authRefresh();
        }
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
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
    isLoading = true;
    try {
      final username = await secureStorage.read(key: usernameKey);
      final password = await secureStorage.read(key: passwordKey);

      if (username != null && password != null) {
        final recordAuth = await client
            .collection('users')
            .authWithPassword(username, password);
        if (recordAuth.record != null) {
          return;
        }
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }

    try {
      final username = const Uuid().v4().replaceAll('-', '');
      final password = const Uuid().v4();
      await client.collection('users').create(body: {
        "name": generator.generate(),
        "username": username,
        "password": password,
        "passwordConfirm": password,
      });

      await secureStorage.write(key: usernameKey, value: username);
      await secureStorage.write(key: passwordKey, value: password);
      await client.collection('users').authWithPassword(username, password);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      isLoading = false;
    }
  }

  @action
  Future logout() async {
    secureStorage.delete(key: authTokenKey);
    client.authStore.clear();
  }

  Uri getFileUrl(RecordModel record, String field) {
    final fileName = record.getListValue<String>(field)[0];
    return client.getFileUrl(record, fileName);
  }

  Future<List<int>> getFile(RecordModel record, String field,
      {bool useCache = true}) async {
    try {
      final fileUrl = getFileUrl(record, field);
      if (!useCache) {
        return await http.readBytes(fileUrl.normalizePath());
      }
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
      await cacheController.putFile(
          bytes, getFileUrl(record, field).toString());
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future removeFile(RecordModel record, String field) async {
    try {
      await cacheController.removeFile(getFileUrl(record, field).toString());
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future _authWithProvider(String providerName) async {
    try {
      isLoading = true;
      final authMethods = await client.collection("users").listAuthMethods();
      final provider = authMethods.authProviders
          .where((am) => am.name.toLowerCase() == providerName)
          .first;
      final responseUrl = await FlutterWebAuth.authenticate(
          url: "${provider.authUrl}$redirectUri",
          callbackUrlScheme: callbackUrlScheme);
      final parsedUri = Uri.parse(responseUrl);
      final code = parsedUri.queryParameters['code']!;
      final response = await client.collection("users").authWithOAuth2(
          providerName, code, provider.codeVerifier, redirectUri);

      final avatar = await http
          .get(Uri.parse(response.meta["avatarUrl"]))
          .then((value) => value.bodyBytes);

      client.collection("users").update(client.authStore.model!.id, body: {
        "name": response.meta["name"],
      }, files: [
        http.MultipartFile.fromBytes(
          'avatar',
          avatar,
          filename: 'avatar',
        ),
      ]);
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
      isLoading = false;
    }
  }
}
