import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:need_resume/need_resume.dart';
import 'widget/main_navigation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResumableState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = <Widget>[
    const LibraryScreen(),
    const Text(
      'Records',
    ),
    const Text(
      'Sets',
    ),
  ];

  @override
  void onResume() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
      statusBarColor: Theme.of(context).secondBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    print('HomeScreen is resumed!');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
      statusBarColor: Theme.of(context).secondBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: MainNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: SafeArea(
          child: _screens[_currentIndex],
        ));
  }
}
