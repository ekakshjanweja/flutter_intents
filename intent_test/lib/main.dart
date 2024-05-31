import 'package:flutter/material.dart';
import 'package:intent_test/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Intent Test",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
