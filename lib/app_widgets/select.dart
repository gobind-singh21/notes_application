import 'package:flutter/material.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/screens/home_screen.dart';
import 'package:notes_application/screens/login_screen.dart';

class Selector extends StatefulWidget {
  const Selector({super.key});

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
