// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'theme_consts.dart';

ThemeData basicTheme(Brightness brightness) => ThemeData(
    brightness: brightness,
    dialogTheme: DialogTheme(
        titleTextStyle: const TextStyle(
            fontSize: 18, color: white, fontWeight: FontWeight.bold),
        elevation: 2,
        iconColor: white,
        contentTextStyle: const TextStyle(fontSize: 16, color: white),
        backgroundColor: darkGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 18,
          color: white,
          letterSpacing: 18 * 0.1,
          fontWeight: FontWeight.bold),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: lightGray,
      selectionColor: lightGray,
      selectionHandleColor: lightGray,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: darkGray,
        secondary: lightGray,
        background: white,
        brightness: brightness));

extension LightThemeEx on ThemeData {
  Color get secondBackgroundColor {
    return brightness == Brightness.light ? darkGray : white;
  }

  Color get brightElementColor {
    return white;
  }

  Color get lightGrayColor {
    return lightGray;
  }

  Color get unknownWordColor {
    return orange;
  }

  Color get savedWordColor {
    return darkOrange;
  }

  TextStyle get sectorTitleStye {
    return const TextStyle(
        fontSize: 16, color: lightGray, fontWeight: FontWeight.bold);
  }

  TextStyle get bookTitleStyle {
    return const TextStyle(
        fontSize: 16,
        color: darkGray,
        fontWeight: FontWeight.w500,
        height: 1.5);
  }

  TextStyle get graphWeekdayStyle {
    return const TextStyle(fontSize: 12, color: lightGray);
  }

  TextStyle get cardTitleStyle {
    return const TextStyle(fontSize: 14, color: darkGray);
  }

  TextStyle get cardSubtitleStyle {
    return const TextStyle(fontSize: 14, color: lightGray);
  }

  TextStyle get bookSubInfoStyle {
    return const TextStyle(fontSize: 12, color: darkGray);
  }

  TextStyle get dialogTextStylePale {
    return const TextStyle(
        fontSize: 16, color: lightGray, fontWeight: FontWeight.bold);
  }

  TextStyle get dialogTextStyleBright {
    return const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  }

  TextStyle get readerHeadPanelTextStyle {
    return const TextStyle(
        color: lightGray, fontWeight: FontWeight.w500, fontSize: 14);
  }

  TextStyle get readerFooterPanelTextStyle {
    return const TextStyle(color: lightGray, fontSize: 12);
  }

  TextStyle get readerPageTextStyle {
    return const TextStyle(
        fontSize: 18, wordSpacing: 2, height: 1.6, color: Colors.black87);
  }

  Color get progressBarActiveColor {
    return orange;
  }
}
