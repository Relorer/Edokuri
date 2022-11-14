import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/controllers/file_controller/provider_file_controller.dart';
import 'package:freader/src/controllers/library_sort_controller/provider_library_sort_controller.dart';
import 'package:freader/src/controllers/translator_controller/provider_translator_controller.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import '../objectbox.g.dart';
import 'pages/home_page/home_page.dart';
import 'theme/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Store? _store;
  OnDeviceTranslator? _translator;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setHighRefreshRate();
    });

    initTranslationMLKit();

    initStore();
  }

  initTranslationMLKit() async {
    final modelManager = OnDeviceTranslatorModelManager();

    await loadLanguageMonel(modelManager, TranslateLanguage.english.bcpCode);
    await loadLanguageMonel(modelManager, TranslateLanguage.russian.bcpCode);

    _translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: TranslateLanguage.russian);
  }

  loadLanguageMonel(
      OnDeviceTranslatorModelManager manager, String model) async {
    if (!await manager.isModelDownloaded(model)) {
      await manager.downloadModel(model);
    }
  }

  Future<void> setHighRefreshRate() async {
    await FlutterDisplayMode.setHighRefreshRate();
    await Future<dynamic>.delayed(
      const Duration(milliseconds: 100),
    );

    setState(() {});
  }

  void initStore() {
    getApplicationDocumentsDirectory().then((dir) {
      setState(() {
        _store =
            Store(getObjectBoxModel(), directory: "${dir.path}/objectbox12");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_store == null || _translator == null) {
      return Container();
    }
    return ProviderTranslatorController(
      translator: _translator!,
      child: ProviderLibrarySortController(
        child: ProviderDbController(
          store: _store!,
          child: Builder(
              builder: (context) => ProviderFileController(
                    dbController: ProviderDbController.ctr(context),
                    child: MaterialApp(
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      theme: basicTheme(),
                      debugShowCheckedModeBanner: false,
                      initialRoute: '/',
                      routes: {
                        '/': (context) => const HomePage(),
                      },
                    ),
                  )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _store?.close();
    _translator?.close();
    super.dispose();
  }
}
