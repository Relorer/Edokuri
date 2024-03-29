// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:open_as_default/open_as_default.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/controllers/common/snackbar_controller/snackbar_controller.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/controllers/stores/package_controller/package_controller.dart';
import 'package:edokuri/src/controllers/stores/pocketbase/migration_anonymous/migration_anonymous.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:edokuri/src/core/widgets/safe_area_with_settings.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/person_screen.dart';
import 'package:edokuri/src/pages/home_page/screens/records_screen/records_screen.dart';
import 'package:edokuri/src/pages/reader/reader_page.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'widget/home_page_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late SettingsController settingsController = getIt<SettingsController>();
  late SnackbarController snackbarController = getIt<SnackbarController>();
  late MLController mlController = getIt<MLController>();

  final List<Widget> _screens = <Widget>[
    const LibraryScreen(),
    const RecordsScreen(),
    const PersonScreen(),
  ];

  @override
  void initState() {
    MigrationAnonymous().load(context);
    getIt<PackageController>().checkUpdate(context);
    OpenAsDefault.getFileIntent.then((value) {
      try {
        if (value != null) {
          getIt<FileController>()
              .addBookFile(value.readAsBytes())
              .then((value) {
            if (value.book == null || !value.isExist) {
              return;
            }
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReaderPage(
                    book: value.book!,
                  ),
                ),
              );
            }
          });
        }
      } catch (e, stacktrace) {
        log("${e.toString()}\n${stacktrace.toString()}");
      }
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (settingsController.isFirstOpening && !mlController.isLoaded) {
        snackbarController
            .showDefaultSnackbar(
                context, "Loading language model...", 5, "Undo")
            .then((value) => {
                  if (value != SnackBarClosedReason.dismiss)
                    mlController.downloadModels()
                });
        await settingsController.setIsFirstOpening(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecordWithInfoCard(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Theme.of(context).secondBackgroundColor),
          child: Container(
            color: Theme.of(context).secondBackgroundColor,
            child: SafeAreaWithSettings(
              child: Scaffold(
                  appBar: const PhantomAppBar(),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  bottomNavigationBar: HomePageNavigation(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  body: _screens[_currentIndex]),
            ),
          ),
        ),
      ),
    );
  }
}
