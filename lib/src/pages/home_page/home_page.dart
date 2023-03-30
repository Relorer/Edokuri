// 🐦 Flutter imports:
import 'package:edokuri/src/controllers/common/file_controller/file_controller.dart';
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/pages/reader/reader_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/snackbar_controller/snackbar_controller.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/controllers/stores/settings_controller/settings_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:edokuri/src/pages/home_page/screens/person_screen/person_screen.dart';
import 'package:edokuri/src/pages/home_page/screens/records_screen/records_screen.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:open_as_default/open_as_default.dart';
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
    OpenAsDefault.getFileIntent.then((value) {
      if (value != null) {
        getIt<FileController>().addBookFile(value.readAsBytes()).then((value) {
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
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (settingsController.isFirstOpening && !mlController.isLoaded) {
        snackbarController
            .showDefaultSnackbar(context, "Loading language model...")
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
              body: SafeArea(
                child: _screens[_currentIndex],
              )),
        ),
      ),
    );
  }
}
