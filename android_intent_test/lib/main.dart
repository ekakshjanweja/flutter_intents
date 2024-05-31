import 'package:android_intent_test/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Android Intent Test',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
