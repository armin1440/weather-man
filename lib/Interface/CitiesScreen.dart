import 'package:flutter/material.dart';
import 'CityCard.dart';

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
              child: ColorfulBox(Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ListTile(
                  title: TextField(),
                  trailing: FlatButton(
                    child: Icon(Icons.search, size: 30, color: Colors.white,),
                  ),
                ),
              ),
              )
            ),
            SizedBox(height: 30,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  ColorfulBox(Text("hi", style: TextStyle(fontSize: 20),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}