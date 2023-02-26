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
    try {
      await account.createOAuth2Session(provider: 'google');
    } on AppwriteException catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
  }

  @action
  Future githubAuth() async {
    try {
      await account.createOAuth2Session(provider: 'github');
    } on AppwriteException catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
  }

  @action
  Future skipAuth() async {
    try {
      await account.createAnonymousSession();
    } on AppwriteException catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
  }

  @action
  Future logout() async {
    try {
      var session = await account.getSession(sessionId: current);
      await account.deleteSession(sessionId: session.$id);
    } on AppwriteException catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
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
}
