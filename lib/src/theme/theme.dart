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
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: paleElement)
          .copyWith(background: white),
    );

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

  TextStyle get bookAuthorStyle {
    return const TextStyle(fontSize: 14, color: paleElement);
  }

  TextStyle get bookSubInfoStyle {
    return const TextStyle(fontSize: 12, color: darkGray);
  }

  TextStyle get dialogTextStyle {
    return const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  }

  Color get progressBarActiveColor {
    return progressBarActive;
  }
}
