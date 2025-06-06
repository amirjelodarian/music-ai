import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EmotionBeat")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to EmotionBeat!"),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to analysis screen
              },
              child: const Text("Analyze Song"),
            ),
          ],
        ),
      ),
    );
  }
}