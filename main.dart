
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Emotion App',
      home: Scaffold(
        appBar: AppBar(title: Text('Emotion Music')),
        body: Center(child: Text('Hello from Music AI')),
      ),
    );
  }
}
