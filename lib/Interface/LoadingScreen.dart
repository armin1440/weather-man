import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  static const String id = "Loading_Screen";

  final spinner = SpinKitCubeGrid(color: Colors.purple,
    size: 80,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.lightBlueAccent,
            child: spinner,
          ),
        ),
      ),
    );
  }
}

