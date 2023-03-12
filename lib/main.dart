// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_config/flutter_config.dart';

// 🌎 Project imports:
import 'package:edokuri/generated/codegen_loader.g.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await setupLocator();
  await getIt.allReady();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const App()),
  );
}
