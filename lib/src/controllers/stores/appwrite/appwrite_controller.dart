import 'dart:developer';

import 'package:appwrite/models.dart' as awModels;
import 'package:flutter_config/flutter_config.dart';
import 'package:appwrite/appwrite.dart';
import 'package:mobx/mobx.dart';

part 'appwrite_controller.g.dart';

class AppwriteController = AppwriteControllerBase with _$AppwriteController;

const String current = "current";

abstract class AppwriteControllerBase with Store {
  final String databaseId = FlutterConfig.get('APPWRITE_DATABASE_EDOKURI');

  final Client client = Client();
  late final Account account = Account(client);
  late final Databases databases = Databases(client);
  late final Storage storage = Storage(client);
  late final Realtime realtime = Realtime(client);

  @observable
  bool isAuthorized = false;

  AppwriteControllerBase() {
    var endpoint = FlutterConfig.get('APPWRITE_API_ENDPOINT');
    var project = FlutterConfig.get('APPWRITE_PROJECT_ID');
    client.setEndpoint(endpoint).setProject(
        project); // For self signed certificates, only use for development
    updateStatus();
  }

  Future<awModels.Document> createDocument(
      {required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions}) async {
    return databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data);
  }

  Future<awModels.Document> updateDocument(
      {required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions}) async {
    return databases.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data);
  }

  Future<awModels.Document> getDocument(
      {required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions}) async {
    return databases.getDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId);
  }

  Future<dynamic> deleteDocument(
      {required String collectionId,
      required String documentId,
      required Map data,
      List<String>? permissions}) async {
    return databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId);
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
      var res = await account.get();
      log(res.email);
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
    } catch (e) {
      log(e.toString());
    } finally {
      await updateStatus();
    }
  }
}
