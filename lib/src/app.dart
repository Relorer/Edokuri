import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:freader/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';

import 'pages/home_page/home_page.dart';
import 'theme/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final DBController _dbController = getIt<DBController>();
  final LibrarySortController _librarySortController =
      getIt<LibrarySortController>();
  final RecordsSortController _recordsSortController =
      getIt<RecordsSortController>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setHighRefreshRate();
    });
  }

  Future<void> setHighRefreshRate() async {
    await FlutterDisplayMode.setHighRefreshRate();
    await Future<dynamic>.delayed(
      const Duration(milliseconds: 100),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<DBController>(create: (_) => _dbController),
          Provider<LibrarySortController>(
              create: (_) => _librarySortController),
          Provider<RecordsSortController>(
              create: (_) => _recordsSortController),
        ],
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
        ));
  }
}
