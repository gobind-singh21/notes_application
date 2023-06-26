import 'package:flutter/material.dart';
import 'package:notes_application/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .toggleThemeMode();
          },
          child: const Text('Toggle Theme'),
        ),
      ),
    );
  }
}
