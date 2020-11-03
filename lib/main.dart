import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'logic/Weather.dart';
main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Weather weather = Weather("Hamedan");
  String text = "hi";

  @override
  Widget build(BuildContext context) {
    return(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch ,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(text),
                FlatButton(color: Colors.blue,
                onPressed: () async {
                  String temp = await weather.getCurrentWeather();
                  setState(() {
                    text = temp;
                  });
                },)
              ],),
            ),
          ),
        ),
      )
    );
  }
}



