import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/controllers/file_controller/provider_file_controller.dart';
import 'package:freader/src/controllers/library_sort_controller/provider_library_sort_controller.dart';
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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setHighRefreshRate();
    });

    getApplicationDocumentsDirectory().then((dir) {
      setState(() {
        _store =
            Store(getObjectBoxModel(), directory: "${dir.path}/objectbox11");
      });
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
    if (_store == null) {
      return Container();
    }
    return ProviderLibrarySortController(
      child: ProviderDbController(
        store: _store!,
        child: Builder(
            builder: (context) => ProviderFileController(
                  dbController: ProviderDbController.ctr(context),
                  child: MaterialApp(
                    theme: basicTheme(),
                    debugShowCheckedModeBanner: false,
                    initialRoute: '/',
                    routes: {
                      '/': (context) => const HomePage(),
                    },
                  ),
                )),
      ),
    );
  }

  @override
  void dispose() {
    _store?.close();
    super.dispose();
  }
}
