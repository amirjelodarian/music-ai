import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/analyze_screen.dart';
import 'screens/suggest_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const EmotionBeatApp());
}

class EmotionBeatApp extends StatefulWidget {
  const EmotionBeatApp({Key? key}) : super(key: key);

  @override
  State<EmotionBeatApp> createState() => _EmotionBeatAppState();
}

class _EmotionBeatAppState extends State<EmotionBeatApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmotionBeat',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(toggleTheme: toggleTheme),
        '/analyze': (context) => const AnalyzeScreen(),
        '/suggest': (context) => const SuggestScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => SettingsScreen(toggleTheme: toggleTheme),
      },
    );
  }
}