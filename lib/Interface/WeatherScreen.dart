import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Weather.dart';
const TextStyle informationTextStyle = TextStyle(color: Colors.white, fontSize: 25, decorationColor: Colors.lightBlueAccent);
const Map jsonNotation = {'temperature': 'main temp',
'weather' : 'weather 0 main'};

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final Weather weather = Weather(city: "Hamedan" );
  Map weatherData = {'city' : 'Hamedan', 'temperature' : 'N/A',
  'weather' : 'N/A'};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("images/rain.png"),
                    )
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: Text("${weatherData['city']}", style: informationTextStyle.copyWith(fontSize: 33),)),
                      SizedBox(
                        height: 30,
                      ),
                      Text("It's ${weatherData['weather']} ", style: informationTextStyle),
                      SizedBox(
                        height: 20,
                      ),
                      Text("${weatherData['temperature']}", style: informationTextStyle),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.deepPurple ),
                    child: FlatButton(
                      child: Text("update", style: informationTextStyle),
                      onPressed: () async{
                        String rawData = '';
                        rawData = await weather.getCurrentWeather();
                        int i = 0;
                        while(rawData.isEmpty && i < 5){
                          rawData = await weather.getCurrentWeather();
                          i++;
                        }
                        if (rawData.isNotEmpty) {
                          setState(() {
                            for (String key in weatherData.keys) {
                              if(!jsonNotation.containsKey(key))
                                continue;
                              String jsonSequence = jsonNotation[key];
                              List<String> sequence = jsonSequence.split(" ");
                              weatherData[key] =
                              sequence.length == 3 ?
                              jsonDecode(rawData)[sequence.elementAt(0)][int.parse(sequence.elementAt(1))]
                              [sequence.elementAt(2)] :
                              jsonDecode(rawData)[sequence.elementAt(
                                  0)][sequence.elementAt(1)];
                            }
                          });
                        }
                      }
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
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
