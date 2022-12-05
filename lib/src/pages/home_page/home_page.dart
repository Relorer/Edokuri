import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:freader/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:freader/src/pages/home_page/screens/person_screen/person_screen.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/records_screen.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'widget/home_page_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = <Widget>[
    const LibraryScreen(),
    const RecordsScreen(),
    const PersonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    setUpBarDefaultStyles(Theme.of(context).secondBackgroundColor);

    return RecordWithInfoCard(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: PhantomAppBar(),
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
    );
  }
}
