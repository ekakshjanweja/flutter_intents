import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _methodChannel = MethodChannel('app.channel.process.urls');

Future<String?> getSharedData() async {
  final sharedData = await _methodChannel.invokeMethod('getSharedUrl');
  if (sharedData is String) {
    return sharedData;
  }

  return null;
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
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
