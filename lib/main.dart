import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EmotionProvider(),
      child: SpeakSenseApp(),
    ),
  );
}

class SpeakSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeakSense',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class EmotionProvider extends ChangeNotifier {
  String _emotion = 'neutral';
  double _intensity = 0.0;

  String get emotion => _emotion;
  double get intensity => _intensity;

  void updateEmotion(String emotion, double intensity) {
    _emotion = emotion;
    _intensity = intensity;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  StreamSubscription? _recorderSubscription;
  StreamController<Food> _audioStreamController = StreamController<Food>();

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder!.openRecorder();
    _recorder!.setSubscriptionDuration(Duration(milliseconds: 200));
  }

  void _startRecording() async {
    await _recorder!.startRecorder(
      toStream: _audioStreamController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: 16000,
    );

    _recorderSubscription = _audioStreamController.stream.listen((buffer) {
      _processAudioFrame(buffer);
    });

    setState(() {
      _isRecording = true;
    });
  }

  void _stopRecording() async {
    await _recorder!.stopRecorder();
    _recorderSubscription?.cancel();
    setState(() {
      _isRecording = false;
    });
  }

  void _processAudioFrame(Food buffer) {
    // Dummy emotion analysis based on random values for demo
    double intensity = min(1.0, buffer.data!.length / 50000.0);
    List<String> emotions = ['calm', 'excited', 'stressed'];
    String selectedEmotion = emotions[Random().nextInt(emotions.length)];

    Provider.of<EmotionProvider>(context, listen: false)
        .updateEmotion(selectedEmotion, intensity);
  }

  @override
  void dispose() {
    _recorderSubscription?.cancel();
    _recorder?.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emotionProv = Provider.of<EmotionProvider>(context);
    Color backgroundColor;
    IconData emotionIcon;

    switch (emotionProv.emotion) {
      case 'calm':
        backgroundColor = Colors.blue.shade100;
        emotionIcon = Icons.self_improvement;
        break;
      case 'excited':
        backgroundColor = Colors.orange.shade100;
        emotionIcon = Icons.favorite;
        break;
      case 'stressed':
        backgroundColor = Colors.red.shade100;
        emotionIcon = Icons.mood_bad;
        break;
      default:
        backgroundColor = Colors.grey.shade200;
        emotionIcon = Icons.self_improvement;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('SpeakSense'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current Emotion:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Icon(
            emotionIcon,
            size: 80,
          ),
          SizedBox(height: 10),
          Text(
            emotionProv.emotion.toUpperCase(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          AudioWaveforms(
            size: Size(double.infinity, 100),
            recorderController: RecorderController(),
            waveStyle: WaveStyle(
              waveColor: backgroundColor,
              showMiddleLine: false,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isRecording ? _stopRecording : _startRecording,
            child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
          ),
        ],
      ),
    );
  }
}