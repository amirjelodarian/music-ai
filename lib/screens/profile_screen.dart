import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل کاربر'),
      ),
      body: const Center(
        child: Text('پروفایل کاربر اینجا نمایش داده می‌شود'),
      ),
    );
  }
}