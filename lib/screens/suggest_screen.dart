import 'package:flutter/material.dart';

class SuggestScreen extends StatelessWidget {
  const SuggestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پیشنهاد موسیقی'),
      ),
      body: const Center(
        child: Text('در حال پیاده‌سازی اسکن چهره و پیشنهاد...'),
      ),
    );
  }
}