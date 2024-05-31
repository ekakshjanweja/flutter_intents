import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:methodchannel/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final channel = const MethodChannel("test_channel");
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Method Channel Test",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
