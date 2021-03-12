import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learner/Interface/MainScreen.dart';
import 'package:learner/logic/DataManager.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{
  final spinner = SpinKitCubeGrid(
    color: Colors.purple,
    size: 100,
  );

  @override
  void initState() {
    super.initState();
    loadCities();
  }
  
  void loadCities() async{
    await Provider.of<DataManager>(context, listen: false).loadCitiesFromFile();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
                  "WeatherMan",
                  style: GoogleFonts.aclonica(fontSize: 40, color: Colors.white),
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

