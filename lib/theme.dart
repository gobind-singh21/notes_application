import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeMode themeMode = ThemeMode.light;

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blue.shade700,
    secondary: Colors.blue.shade500,
    surfaceTint: Colors.purple[900],
  ),
  fontFamily: GoogleFonts.lato().fontFamily,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 0.0,
    backgroundColor: Colors.blue.shade800,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (states) {
          return Colors.white;
        },
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(100, 90, 90, 90),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  hintColor: Colors.grey,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  primaryColor: const Color.fromARGB(255, 80, 117, 255),
  scaffoldBackgroundColor: const Color.fromARGB(100, 100, 100, 100),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.black,
    shadowColor: Color.fromARGB(75, 158, 158, 158),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
    ),
  ),
  cardColor: const Color.fromARGB(100, 90, 90, 90),
  shadowColor: Colors.white,
);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.cyan.shade600,
    secondary: Colors.cyan.shade200,
  ),
  primaryColor: Colors.blue,
  fontFamily: GoogleFonts.lato().fontFamily,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0.0,
    backgroundColor: Colors.blue,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (states) {
          return Colors.black;
        },
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.cyanAccent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  hintColor: Colors.grey,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  brightness: Brightness.light,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
    ),
  ),
  cardColor: const Color.fromARGB(100, 210, 210, 210),
  shadowColor: Colors.black,
);
