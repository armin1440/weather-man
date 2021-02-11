import 'package:flutter/material.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Options", style: TextStyle(fontSize: 33),),
                SizedBox(height: 10,),
                Option("Humidity"),
                Option("Wind speed"),
                Option("Pressure"),
                Option("Feels like"),
              ],
            ),
          ),
        ),
    );
  }
}

class Option extends StatelessWidget{
  final String title;
  Option(this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(title),
      trailing: RaisedButton(
        color: Colors.black,
        // onPressed: ,
      ),
    );
  }
}