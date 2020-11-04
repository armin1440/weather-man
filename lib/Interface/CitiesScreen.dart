import 'package:flutter/material.dart';

class CitiesScreen extends StatefulWidget{

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]) ),
              child: ListTile(
                title: TextField(),
                trailing: FlatButton(
                  child: Icon(Icons.search, size: 30, color: Colors.blue,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}