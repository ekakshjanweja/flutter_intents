import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

const String appId = "com.example.android_intent_test";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];

  String _sharedText = "";

  @override
  void initState() {
    super.initState();
    getSharedData();
  }

  void getSharedData() {
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);

        setState(() {
          _sharedText = _sharedFiles
              .map((f) => f.toMap()["path"])
              .join(",\n****************\n");
        });

        print(_sharedFiles.map((f) => f.toMap()["path"]));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        _sharedText = _sharedFiles
            .map((f) => f.toMap()["path"])
            .join(",\n****************\n");
        print(_sharedFiles.map((f) => f.toMap()));

        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.instance.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Shared files:"),
              Text(
                _sharedText,
                style: const TextStyle(fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
