import 'package:flutter/material.dart';
import 'package:emotionbeat/screens/home_screen.dart';

void main() => runApp(const EmotionBeatApp());

class EmotionBeatApp extends StatelessWidget {
  const EmotionBeatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmotionBeat',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}