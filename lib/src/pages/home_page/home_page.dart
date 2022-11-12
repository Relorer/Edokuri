import 'package:flutter/material.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:freader/src/theme/system_bars.dart';
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
    const Text(
      'Records',
    ),
    const Text(
      'Sets',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    setUpBarDefaultStyles(context);

    return Scaffold(
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
        ));
  }
}
