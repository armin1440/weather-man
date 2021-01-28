import 'package:flutter/material.dart';
import 'ColorfulBox.dart';
import 'WeatherScreen.dart';

class CityTile extends StatelessWidget{
  final String _city;
  final Function _delete;

  CityTile(this._city, this._delete);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ColorfulBox(
          GestureDetector(
            onHorizontalDragUpdate: (details) => _delete(_city),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherScreen(city))),
            child: ListTile(leading: Text(city, style: TextStyle(fontSize: 20, color: Colors.white),),
              trailing: Icon(Icons.ac_unit),
            ),
          )
      ),
    );
  }

  String get city{
    return _city;
  }

}