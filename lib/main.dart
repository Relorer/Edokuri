import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:freader/generated/codegen_loader.g.dart';
import 'package:freader/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:freader/src/core/service_locator.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await setupLocator();
  await getIt.allReady();
  await getIt<PocketbaseController>().load();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const App()),
  );
}
