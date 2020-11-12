import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Weather.dart';
const TextStyle informationTextStyle = TextStyle(color: Colors.white, fontSize: 25, decorationColor: Colors.lightBlueAccent);
const Map jsonNotation = {'temperature': 'main temp', 'weather' : 'weather 0 main'};

class WeatherScreen extends StatefulWidget {
  final Weather cityWeather; //=  Weather(city: "Hamedan" );

  WeatherScreen(this.cityWeather);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();

}

class _WeatherScreenState extends State<WeatherScreen> {
  Map weatherDataMap;

  @override
  void initState() {
    String cityName = widget.cityWeather.getCity;
    weatherDataMap = { 'city' : cityName , 'temperature' : 'N/A' , 'weather' : 'N/A' };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Container(
          color: Colors.lightBlueAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                    child: Image.asset("images/rain.png"),
                  )
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: Text("${weatherDataMap['city']}", style: informationTextStyle.copyWith(fontSize: 33),)),
                      SizedBox(
                        height: 30,
                      ),
                      Text("It's ${weatherDataMap['weather']} ", style: informationTextStyle),
                      SizedBox(
                        height: 20,
                      ),
                      Text("${weatherDataMap['temperature']}", style: informationTextStyle),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.deepPurple ),
                    child: FlatButton(
                      child: Text("update", style: informationTextStyle),
                      onPressed: () async{
                        String rawData = '';
                        rawData = await widget.cityWeather.getCurrentWeather();
                        int i = 0;
                        while(rawData.isEmpty && i < 5){
                          rawData = await widget.cityWeather.getCurrentWeather();
                          i++;
                        }
                        if (rawData.isNotEmpty) {
                          setState(() {
                            for (String key in weatherDataMap.keys) {
                              if(!jsonNotation.containsKey(key))
                                continue;
                              String jsonSequence = jsonNotation[key];
                              List<String> sequence = jsonSequence.split(" ");
                              weatherDataMap[key] =
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
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
