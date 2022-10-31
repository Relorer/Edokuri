import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.light,
      backgroundColor: const Color(0xffF2F2F2),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 18,
            color: Color(0xFFF2F2F2),
            letterSpacing: 18 * 0.1,
            fontWeight: FontWeight.bold),
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF292F40)),

      // iconTheme: IconThemeData(
      //   // color: Colors.red,
      //   size: 25.0,
      //   color: Colors.blue,
      // ),

      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   backgroundColor: Colors.red,
      //   foregroundColor: Colors.purple,
      // ),

      // accentColor: Colors.orange,
      // buttonTheme: ButtonThemeData(
      //   height: 80,
      //   buttonColor: Colors.deepPurple,
      //   textTheme: ButtonTextTheme.accent,
      // ),

      // bottomAppBarColor: Colors.deepPurple,
      // cardColor: Colors.orange.shade100,
      // scaffoldBackgroundColor: Colors.yellow,
    );

extension LightThemeEx on ThemeData {
  Color get secondBackgroundColor {
    return const Color(0xFF292F40);
  }

  Color get brightElementColor {
    return const Color(0xFFF2F2F2);
  }

  Color get paleElementColor {
    return const Color(0xFF778797);
  }

  TextStyle get sectorTitleStye {
    return const TextStyle(
        fontSize: 16, color: Color(0xFF778797), fontWeight: FontWeight.bold);
  }

  TextStyle get bookTitleStyle {
    return const TextStyle(
        fontSize: 16,
        color: Color(0xFF292F40),
        fontWeight: FontWeight.w500,
        height: 1.5);
  }

  TextStyle get bookAuthorStyle {
    return const TextStyle(fontSize: 14, color: Color(0xFF778797));
  }

  TextStyle get bookSubInfoStyle {
    return const TextStyle(fontSize: 12, color: Color(0xFF292F40));
  }

  Color get progressBarActiveColor {
    return const Color(0xFFFBD143);
  }
}
