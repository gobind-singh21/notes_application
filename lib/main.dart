import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_application/global/global.dart';
import 'package:notes_application/screens/home_screen.dart';
import 'package:notes_application/screens/login_screen.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_provider.dart';

Future<void> initTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print('build');
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    currentFirebaseUser = fAuth.currentUser;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    return Consumer<ThemeProvider>(
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value.currentThemeMode == ThemeModeType.light
              ? ThemeMode.light
              : ThemeMode.dark,
          home: (currentFirebaseUser == null)
              ? const LoginScreen()
              : const HomeScreen(),
        );
      },
    );
  }
}
