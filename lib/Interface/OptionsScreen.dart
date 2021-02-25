import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Option.dart';
import 'NavigationBar.dart';

class OptionsScreen extends StatelessWidget {

  final Function changeColor = (Color color){
    if(color == Colors.black){
      color = Colors.blue;
    }
    else
      color = Colors.black;
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: NavigationBar(),
          backgroundColor: Colors.lightBlue,
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: Text("Options", style: TextStyle(fontSize: 33),)),
                      SizedBox(height: 10,),
                      Option("Humidity"),
                      Option("Wind speed"),
                      Option("Pressure"),
                      Option("Feels like"),
                    ],
              ),
            ),
          ),
        ),
    );
  }
}
