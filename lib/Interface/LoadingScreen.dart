import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learner/Interface/CitiesScreen.dart';
import 'package:learner/logic/Data.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final spinner = SpinKitCubeGrid(
    color: Colors.purple,
    size: 80,
  );

  @override
  void initState() {
    super.initState();
    findWeatherOfHere();
  }

  void findWeatherOfHere() async{
    await Provider.of<Data>(context, listen: false).findWeatherByLocation();
    // print("time to push");
    // Navigator.push(context, MaterialPageRoute(builder: (context) => CitiesScreen()));
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (BuildContext context) => CitiesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.lightBlueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Weather Man",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 60,),
                spinner
              ],
            ),
          ),
        ),
      ),
    );
  }
}

