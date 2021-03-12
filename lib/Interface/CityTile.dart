import 'dart:ui';
import 'package:flutter/material.dart';
import 'ColorfulBox.dart';
import 'WeatherScreen.dart';
import 'package:provider/provider.dart';
import 'package:learner/logic/DataManager.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
// TextStyle(fontSize: 20, color: Colors.white)

class CityTile extends StatelessWidget{
  final String _city;
  final Container dismissBackground = Container(
    child: Icon(Icons.delete),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        gradient: RadialGradient(colors: [Colors.red, Colors.lightBlue], radius: 2 )
    ),
  );

  CityTile(this._city);

  @override
  Widget build(BuildContext context){
    final ColorfulBox colorfulBox = ColorfulBox(
      GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherScreen(_city))),
        child: ListTile(leading: Text(_city, style: GoogleFonts.oxygen(fontSize: 20, color: Colors.white),),
          trailing: SizedBox(width: 80,
            child: Row(children: <Widget>[
              Expanded(
                child: Text("${Provider.of<DataManager>(context).getWeatherInfo(_city,'temperature')} \u2103"),
                flex: 4,
              ),
              // SizedBox(width: 20,),
              Expanded(
                child: BoxedIcon(Provider.of<DataManager>(context).getWeatherIcon(_city)),
                flex: 6,
              ),
            ],
            ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
        onDismissed: (direction){
          Provider.of<DataManager>(context, listen: false).removeCity(_city);
        },
        key: Key(_city),
        background: dismissBackground,
        child: colorfulBox,
      ),
    );
  }

  String get city{
    return _city;
  }
}
