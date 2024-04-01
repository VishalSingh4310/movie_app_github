import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeClass {
  Color lightPrimaryColor = Colors.orange;
  Color darkPrimaryColor = Colors.orange;

  static ThemeData lightTheme() {
    var baseTheme = ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        secondaryHeaderColor: Colors.grey.shade200,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.black));

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.white,
          secondary: Colors.orange,
          tertiary: const Color.fromARGB(255, 131, 131, 131),
          tertiaryContainer: const Color.fromARGB(71, 255, 255, 255)),
      primaryColor: Colors.orange.shade900,
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    var baseTheme = ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.black,
        secondaryHeaderColor: HexColor('#141414'),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.white));

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          secondary: Colors.orange,
          tertiary: const Color.fromARGB(255, 97, 97, 97),
          tertiaryContainer: const Color.fromARGB(71, 29, 29, 29)),
      primaryColor: Colors.orange.shade900,
      useMaterial3: true,
    );
  }
}
