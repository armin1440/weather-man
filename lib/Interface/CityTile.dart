import 'package:flutter/material.dart';
import 'ColorfulBox.dart';
import 'WeatherScreen.dart';
import 'package:provider/provider.dart';
import 'package:learner/logic/Data.dart';
import 'package:weather_icons/weather_icons.dart';

class CityTile extends StatelessWidget{
  final String _city;

  CityTile(this._city);

  @override
  Widget build(BuildContext context){
    // Provider.of<Data>(context, listen: false).updateWeather(_city);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ColorfulBox(
          GestureDetector(
            onHorizontalDragUpdate: (details) => Provider.of<Data>(context, listen: false).removeCity(_city),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherScreen(city))),
            child: ListTile(leading: Text(city, style: TextStyle(fontSize: 20, color: Colors.white),),
                trailing: SizedBox(width: 80,
                  child: Row(children: <Widget>[
                    Expanded(child: Text("${Provider.of<Data>(context).cityWeather(city)['temperature']}"), flex: 2,),
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: BoxedIcon(WeatherIcons.celsius),
                      ),
                      flex: 1,
                    ),
                    // SizedBox(width: 20,),
                    Expanded(child: BoxedIcon(Provider.of<Data>(context).cityWeather(city)['icon']), flex: 6,),
                  ],
                  ),
                ),
              ),
          ),
      ),
    );
  }

  String get city{
    return _city;
  }
}
