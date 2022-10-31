import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freader/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:freader/theme.dart';
import '../../widgets/main_navigation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const List<Widget> _screens = <Widget>[
    LibraryScreen(),
    Text(
      'Records',
    ),
    Text(
      'Sets',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
        statusBarColor: Theme.of(context).secondBackgroundColor));

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
