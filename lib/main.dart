import 'package:flutter/material.dart';
import 'package:notes_application/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // print(Dimensions.screenHeight);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        "/": (context) => LoginScreen(),
        // AppRoutes.homeRoute: (context) => HomePage(),
        // AppRoutes.loginRoute: (context) => LoginScreen()
        // AppRoutes.productScreenRoute: (context) => ProductScreen(_product)
      },
    );
  }
}
