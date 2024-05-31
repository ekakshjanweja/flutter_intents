import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('com.example.flutter/text');

  String _receivedText = 'No text received yet';

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleIncomingIntent);
  }

  Future<void> _handleIncomingIntent(MethodCall call) async {
    if (call.method == "sendText") {
      setState(() {
        _receivedText = call.arguments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_receivedText),
      ),
    );
  }
}
