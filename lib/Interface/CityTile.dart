import 'package:flutter/material.dart';
import 'ColorfulBox.dart';
import 'WeatherScreen.dart';

class CityTile extends StatelessWidget{
  final String city;

  CityTile(this.city);

  @override
  Widget build(BuildContext context){
    return ColorfulBox(
        GestureDetector(
          onHorizontalDragUpdate: (details) => print("deleted"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherScreen(city))),
          child: ListTile(leading: Text(city, style: TextStyle(fontSize: 20, color: Colors.white),),
            trailing: Icon(Icons.ac_unit),
          ),
        )
    );
  }

}