import 'package:flutter/material.dart';

class AnalyzeScreen extends StatelessWidget {
  const AnalyzeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحلیل آهنگ'),
      ),
      body: const Center(
        child: Text('در حال پیاده‌سازی انتخاب و تحلیل آهنگ...'),
      ),
    );
  }
}