// 🎯 Dart imports:
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/snackbar_controller/snackbar_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';

part 'package_controller.g.dart';

const downloaderSendPort = "downloader_send_port";

class PackageControllerFactory {
  Future<PackageController> getPackageController() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return PackageController(packageInfo);
  }
}

class PackageController = PackageControllerBase with _$PackageController;

abstract class PackageControllerBase with Store {
  final PackageInfo packageInfo;

  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;
  String get buildSignature => packageInfo.buildSignature;
  String get installerStore => packageInfo.installerStore ?? "";

  @observable
  int progress = -1;

  @observable
  VersionWithDownloadUrl? latestVersion;

  @computed
  bool get thereIsNewVersion => latestVersion == null
      ? false
      : compareVersions(version, latestVersion!.version) < 0;

  PackageControllerBase(this.packageInfo);

  Future checkUpdate(BuildContext context) async {
    try {
      VersionWithDownloadUrl? latestVersion = await getLatestVersion();

      if (latestVersion != null) {
        this.latestVersion = latestVersion;

        if (thereIsNewVersion &&
            latestVersion.downloadUrl.isNotEmpty &&
            context.mounted) {
          final result = await getIt<SnackbarController>().showDefaultSnackbar(
              context, "A new version is available", 10, "Update");

          if (result == SnackBarClosedReason.action) {
            update();
          }
        }
      }
    } catch (e, stacktrace) {
      log("${e.toString()}\n${stacktrace.toString()}");
    }
  }

  Future update() async {
    if (latestVersion != null) {
      await downloadAndInstallApk(latestVersion!.downloadUrl);
    }
  }

  Future<String?> getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<void> downloadAndInstallApk(String url) async {
    ReceivePort port = ReceivePort();

    IsolateNameServer.removePortNameMapping(downloaderSendPort);
    IsolateNameServer.registerPortWithName(port.sendPort, downloaderSendPort);

    port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      progress = data[2];
      if (status == DownloadTaskStatus.complete.value) {
        FlutterDownloader.open(taskId: id);
        IsolateNameServer.removePortNameMapping(downloaderSendPort);
      } else if (status == DownloadTaskStatus.failed.value) {
        IsolateNameServer.removePortNameMapping(downloaderSendPort);
      }
    });

    final directory = await getSavedDir();
    if (directory == null) {
      return;
    }

    final fileName = "edokuri-${latestVersion?.version}.apk";

    deleteFile("$directory/$fileName");
    await FlutterDownloader.enqueue(
      url: url,
      fileName: fileName,
      savedDir: directory,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  Future deleteFile(String path) async {
    try {
      final file = File(path);
      await file.delete();
    } catch (e) {
      return;
    }
  }

  Future<VersionWithDownloadUrl?> getLatestVersion() async {
    var headers = {
      'Accept': 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
      'Cookie': '_octo=GH1.1.366210639.1679218066; logged_in=no'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.github.com/repos/Relorer/Edokuri/releases/latest'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      Map<String, dynamic> jsonMap = json.decode(body);

      String version = jsonMap['tag_name'];
      String downloadUrl = jsonMap['assets'][0]['browser_download_url'];

      return VersionWithDownloadUrl(version, downloadUrl);
    } else {
      return null;
    }
  }

  int compareVersions(String version1, String version2) {
    var version1Parts = version1.split('.').map(int.parse).toList();
    var version2Parts = version2.split('.').map(int.parse).toList();

    for (var i = 0; i < version1Parts.length; i++) {
      if (version1Parts[i] < version2Parts[i]) {
        return -1;
      } else if (version1Parts[i] > version2Parts[i]) {
        return 1;
      }
    }

    return 0;
  }
}

class DownloadClass {
  @pragma('vm:entry-point')
  static void callback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName(downloaderSendPort);
    if (send != null) {
      send.send([id, status.value, progress]);
    }
  }
}

class VersionWithDownloadUrl {
  final String version;
  final String downloadUrl;

  VersionWithDownloadUrl(this.version, this.downloadUrl);
}
