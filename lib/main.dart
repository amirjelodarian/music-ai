import 'package:flutter/material.dart';

void main() {
  runApp(EmotionMusicApp());
}

class EmotionMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emotion Music AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: EmotionHomePage(),
    );
  }
}

class EmotionHomePage extends StatefulWidget {
  @override
  _EmotionHomePageState createState() => _EmotionHomePageState();
}

class _EmotionHomePageState extends State<EmotionHomePage> {
  String detectedEmotion = '';
  bool isAnalyzing = false;

  void analyzeMusic() async {
    setState(() {
      isAnalyzing = true;
      detectedEmotion = '';
    });

    // شبیه‌سازی تحلیل احساسات با تأخیر
    await Future.delayed(Duration(seconds: 2));

    // احساس فرضی برگردون
    setState(() {
      detectedEmotion = '😄 خوشحال';
      isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحلیل احساسات موسیقی'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_note, size: 100, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              'روی دکمه بزن تا احساساتت تحلیل بشه',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: isAnalyzing ? null : analyzeMusic,
              child: Text('شروع تحلیل'),
            ),
            SizedBox(height: 40),
            if (isAnalyzing) CircularProgressIndicator(),
            if (detectedEmotion.isNotEmpty)
              Text(
                'احساس شناسایی شده: $detectedEmotion',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}