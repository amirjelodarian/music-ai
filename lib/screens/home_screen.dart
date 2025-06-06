import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool) toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmotionBeat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.music_note),
                label: const Text('انتخاب آهنگ از حافظه'),
                onPressed: () {
                  Navigator.pushNamed(context, '/analyze');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.mic),
                label: const Text('ضبط آهنگ با میکروفن'),
                onPressed: () {
                  Navigator.pushNamed(context, '/analyze');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.face),
                label: const Text('اسکن چهره و تشخیص احساس'),
                onPressed: () {
                  Navigator.pushNamed(context, '/suggest');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}