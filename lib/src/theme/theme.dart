import 'package:flutter/material.dart';
import 'theme_consts.dart';

ThemeData basicTheme() => ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 18,
          color: white,
          letterSpacing: 18 * 0.1,
          fontWeight: FontWeight.bold),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: paleElement,
      selectionColor: paleElement,
      selectionHandleColor: paleElement,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: paleElement, background: white));

extension LightThemeEx on ThemeData {
  Color get secondBackgroundColor {
    return darkGray;
  }

  Color get brightElementColor {
    return white;
  }

  Color get paleElementColor {
    return paleElement;
  }

  Color get unknownWordColor {
    return unknownWord;
  }

  Color get savedWordColor {
    return savedWord;
  }

  TextStyle get sectorTitleStye {
    return const TextStyle(
        fontSize: 16, color: paleElement, fontWeight: FontWeight.bold);
  }

  TextStyle get bookTitleStyle {
    return const TextStyle(
        fontSize: 16,
        color: darkGray,
        fontWeight: FontWeight.w500,
        height: 1.5);
  }

  TextStyle get graphWeekdayStyle {
    return const TextStyle(fontSize: 12, color: paleElement);
  }

  TextStyle get bookAuthorStyle {
    return const TextStyle(fontSize: 14, color: paleElement);
  }

  TextStyle get bookSubInfoStyle {
    return const TextStyle(fontSize: 12, color: darkGray);
  }

  TextStyle get dialogTextStylePale {
    return const TextStyle(
        fontSize: 16, color: paleElement, fontWeight: FontWeight.bold);
  }

  TextStyle get dialogTextStyleBright {
    return const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  }

  TextStyle get readerHeadPanelTextStyle {
    return const TextStyle(
        color: paleElement, fontWeight: FontWeight.w500, fontSize: 14);
  }

  TextStyle get readerFooterPanelTextStyle {
    return const TextStyle(color: paleElement, fontSize: 12);
  }

  TextStyle get readerPageTextStyle {
    return const TextStyle(
        fontSize: 18, wordSpacing: 2, height: 1.6, color: Colors.black87);
  }

  Color get progressBarActiveColor {
    return progressBarActive;
  }
}
