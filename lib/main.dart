// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/codegen_loader.g.dart';
import 'package:edokuri/src/controllers/stores/package_controller/package_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await setupLocator();
  await getIt.allReady();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  await FlutterDownloader.registerCallback(DownloadClass.callback);

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const App()),
  );
}
