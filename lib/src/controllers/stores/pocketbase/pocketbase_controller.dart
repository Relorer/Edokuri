import 'dart:convert';
import 'dart:developer';

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:mobx/mobx.dart';
import 'package:pocketbase/pocketbase.dart';

part 'pocketbase_controller.g.dart';

class PocketbaseController = PocketbaseControllerBase
    with _$PocketbaseController;

final pocketbaseUrl = FlutterConfig.get("POCKETBASE_URL");
final redirectUri = "$pocketbaseUrl/auth-redirect";
const callbackUrlScheme = "https";
const authTokenKey = "auth_token_key";

abstract class PocketbaseControllerBase with Store {
  final secureStorage = getIt<FlutterSecureStorage>();
  final pb = PocketBase(pocketbaseUrl);

  @observable
  bool isAuthorized = false;

  PocketbaseControllerBase() {
    pb.authStore.onChange.listen((e) {
      isAuthorized = pb.authStore.token.isNotEmpty;

      final encoded = jsonEncode(<String, dynamic>{
        "token": e.token,
        "model": e.model,
      });

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

      pb.authStore.save(token, model);
    }
  }

  @action
  Future googleAuth() async {
    _authWithProvider("google");
  }

  @action
  Future githubAuth() async {
    _authWithProvider("github");
  }

  @action
  Future skipAuth() async {}

  @action
  Future logout() async {
    pb.authStore.clear();
  }

  Future _authWithProvider(String providerName) async {
    try {
      final authMethods = await pb.collection("users").listAuthMethods();
      final provider = authMethods.authProviders
          .where((am) => am.name.toLowerCase() == providerName)
          .first;
      final responseUrl = await FlutterWebAuth.authenticate(
          url: "${provider.authUrl}$redirectUri",
          callbackUrlScheme: callbackUrlScheme);
      final parsedUri = Uri.parse(responseUrl);
      final code = parsedUri.queryParameters['code']!;
      await pb.collection("users").authWithOAuth2(
          providerName, code, provider.codeVerifier, redirectUri);
    } catch (e) {
      log(e.toString());
    }
  }
}
