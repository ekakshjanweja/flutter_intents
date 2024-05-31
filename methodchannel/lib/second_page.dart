import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _methodChannel = MethodChannel('app.channel.process.data');

Future<String?> getSharedData() async {
  final sharedData = await _methodChannel
      .invokeMethod('getSharedText'); // <- Name of the method from Kotlin
  if (sharedData is String) {
    return sharedData;
  }

  return null;
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String dataShared = 'No data';

  @override
  void initState() {
    super.initState();

    getSharedData().then((value) {
      setState(() {
        dataShared = value ?? "Empty data";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(dataShared),
      ),
    );
  }
}
