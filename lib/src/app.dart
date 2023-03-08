// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/book_repository/book_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/record_repository/record_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:edokuri/src/controllers/stores/repositories/user_repository/user_repository.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/library_sort_controller/library_sort_controller.dart';
import 'package:edokuri/src/controllers/stores/sort_controllers/records_sort_controller/record_sort_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/pages/auth_page/auth_page.dart';
import 'pages/home_page/home_page.dart';
import 'theme/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = getIt<UserRepository>();
  final BookRepository _bookRepository = getIt<BookRepository>();
  final RecordRepository _recordRepository = getIt<RecordRepository>();
  final SetRepository _setRepository = getIt<SetRepository>();

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
        providers: [
          Provider<BookRepository>(create: (_) => _bookRepository),
          Provider<UserRepository>(create: (_) => _userRepository),
          Provider<RecordRepository>(create: (_) => _recordRepository),
          Provider<SetRepository>(create: (_) => _setRepository),
          Provider<LibrarySortController>(
              create: (_) => _librarySortController),
          Provider<RecordsSortController>(
              create: (_) => _recordsSortController),
        ],
        child: Observer(
          builder: (BuildContext context) {
            var pocketbase = getIt<PocketbaseController>();
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: basicTheme(),
              debugShowCheckedModeBanner: false,
              home:
                  pocketbase.isAuthorized ? const HomePage() : const AuthPage(),
            );
          },
        ));
  }
}
