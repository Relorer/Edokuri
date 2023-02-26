import 'dart:developer';

import 'package:flutter_config/flutter_config.dart';
import 'package:appwrite/appwrite.dart';
import 'package:mobx/mobx.dart';

part 'appwrite_controller.g.dart';

class AppwriteController = AppwriteControllerBase with _$AppwriteController;

const String current = "current";

abstract class AppwriteControllerBase with Store {
  final Client client = Client();
  late Account account = Account(client);

  @observable
  bool isAuthorized = false;

  AppwriteControllerBase() {
    client.setEndpoint(FlutterConfig.get('APPWRITE_API_ENDPOINT')!).setProject(
        FlutterConfig.get(
            'APPWRITE_PROJECT_ID')!); // For self signed certificates, only use for development

    updateStatus();
  }

  @action
  Future googleAuth() async {
    try {
      await account.createOAuth2Session(provider: 'google');
      updateStatus();
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future githubAuth() async {
    try {
      await account.createOAuth2Session(provider: 'github');
      updateStatus();
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future skipAuth() async {
    try {
      await account.createAnonymousSession();
      updateStatus();
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future logout() async {
    try {
      await account.deleteSession(sessionId: current);
      updateStatus();
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateStatus() async {
    isAuthorized = (await account.getSession(sessionId: current)).current;
  }
}
