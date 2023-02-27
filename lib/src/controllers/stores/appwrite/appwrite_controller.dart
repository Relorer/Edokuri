import 'dart:developer';

import 'package:flutter_config/flutter_config.dart';
import 'package:appwrite/appwrite.dart';
import 'package:mobx/mobx.dart';

part 'appwrite_controller.g.dart';

class AppwriteController = AppwriteControllerBase with _$AppwriteController;

const String current = "current";

abstract class AppwriteControllerBase with Store {
  final Client client = Client();
  late final Account account = Account(client);

  @observable
  bool isAuthorized = false;

  AppwriteControllerBase() {
    var endpoint = FlutterConfig.get('APPWRITE_API_ENDPOINT')!;
    var project = FlutterConfig.get('APPWRITE_PROJECT_ID')!;
    client.setEndpoint(endpoint).setProject(
        project); // For self signed certificates, only use for development
    updateStatus();
  }

  @action
  Future googleAuth() async {
    await _runWithUpdate(
      () async {
        await account.createOAuth2Session(provider: 'google');
      },
    );
  }

  @action
  Future githubAuth() async {
    await _runWithUpdate(
      () async {
        await account.createOAuth2Session(provider: 'github');
      },
    );
  }

  @action
  Future skipAuth() async {
    await _runWithUpdate(
      () async {
        await account.createAnonymousSession();
      },
    );
  }

  @action
  Future logout() async {
    await _runWithUpdate(
      () async {
        var session = await account.getSession(sessionId: current);
        await account.deleteSession(sessionId: session.$id);
      },
    );
  }

  @action
  Future updateStatus() async {
    try {
      await account.get();
      isAuthorized = true;
    } on AppwriteException catch (e) {
      log(e.toString());
      isAuthorized = false;
    }
  }

  Future _runWithUpdate(Future<void> Function() f) async {
    try {
      await f();
    } on AppwriteException catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
  }
}
