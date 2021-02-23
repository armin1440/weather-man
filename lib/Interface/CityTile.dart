import 'dart:ui';

import 'package:flutter/material.dart';
import 'ColorfulBox.dart';
import 'WeatherScreen.dart';
import 'package:provider/provider.dart';
import 'package:learner/logic/Data.dart';
import 'package:weather_icons/weather_icons.dart';

class CityTile extends StatelessWidget{
  final String _city;
  final ColorfulBox colorfulBox = ColorfulBox(
    GestureDetector(
      // onHorizontalDragUpdate: (details) => Provider.of<Data>(context, listen: false).removeCity(_city),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherScreen(city))),
      child: ListTile(leading: Text(city, style: TextStyle(fontSize: 20, color: Colors.white),),
        trailing: SizedBox(width: 80,
          child: Row(children: <Widget>[
            Expanded(
              child: Text("${Provider.of<Data>(context).cityWeather(city)['temperature']} \u2103"),
              flex: 4,
            ),
            // SizedBox(width: 20,),
            Expanded(
              child: BoxedIcon(Provider.of<Data>(context).cityWeather(city)['icon']),
              flex: 6,
            ),
          ],
          ),
        ),
      ),
    ),
  );
  final Container dismissBackground = Container(
    child: Icon(Icons.delete),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        gradient: RadialGradient(colors: [Colors.green, Colors.lightBlue], radius: 2 )
    ),
  );

  CityTile(this._city);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
        onDismissed: (direction){
          Provider.of<Data>(context, listen: false).removeCity(_city);
        },
        key: Key(colorfulBox.toStringShort()),
        background: dismissBackground,
        child: colorfulBox,
      ),
    );
  }

  String get city{
    return _city;
  }
}
