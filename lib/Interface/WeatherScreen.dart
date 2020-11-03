import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                Expanded(
                    flex:5 ,
                    child: Image.asset("images/rain.png")
                ),
                Expanded(
                  flex: 1,
                  child: Text("rain"),
                ),
                Expanded(
                  flex: 1,
                  child: Text("tempreture"),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
