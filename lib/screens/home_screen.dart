import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String connectionStatus = " ";

  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print("new connectivity status: $result");
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoButton(
          color: Colors.blueAccent,
          onPressed: () {
            checkStatus();
          },
          child: const Text("Click Me "),
        ),
      ),
    );
  }

  void checkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Network connected to Mobile Data"),
        ),
      );
    } else if (connectivityResult == ConnectivityResult.wifi) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Network connected to Wifi Network"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please check your internet connection"),
        ),
      );
    }
  }
}
