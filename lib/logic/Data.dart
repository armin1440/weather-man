import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:learner/Interface/CityTile.dart';
import 'package:learner/logic/Weather.dart';

const Map jsonNotation = {'temperature': 'main temp', 'weather' : 'weather 0 main'};

class Data extends ChangeNotifier{
  List<CityTile> _cityWidgets = List<CityTile>();
  List<Map> _weatherDataMaps = List<Map>();

  void addCity(String city){
    if(!cityExists(city) && city.isNotEmpty){
      _cityWidgets.add(CityTile(city));
      _weatherDataMaps.add({'city': city, 'temperature': '?', 'weather': '?'});
      notifyListeners();
    }
  }

  void removeCity(String city){
    if(cityExists(city)) {
      for(Map weatherData in _weatherDataMaps){
        if(weatherData['city'] == city){
          _weatherDataMaps.remove(weatherData);
          print("$city weather removed from maps");
          break;
        }
      }
      for (CityTile cityTile in _cityWidgets) {
        if (cityTile.city == city) {
          _cityWidgets.remove(cityTile);
          print("$city weather removed from widgets");
          break;
        }
      }
      notifyListeners();
    }
  }

  int widgetNumbers(){
    return _cityWidgets.length;
  }

  void updateWeather(String city) async{
    Map weatherDataMap = Map();
    if(cityExists(city)) {
      for (Map map in _weatherDataMaps) {
        if (map['city'] == city) {
          weatherDataMap = map;
        }
      }
    }
    String rawData = '';
    Weather cityWeather = Weather(city: city);
    rawData = await cityWeather.getCurrentWeather();
    int i = 0;
    while(rawData.isEmpty && i < 5){
      rawData = await cityWeather.getCurrentWeather();
      i++;
    }
    if (rawData.isNotEmpty) {
        for (String key in weatherDataMap.keys) {
          if(!jsonNotation.containsKey(key))
            continue;
          String jsonSequence = jsonNotation[key];
          List<String> sequence = jsonSequence.split(" ");
          if(sequence.length == 3)
            weatherDataMap[key] = jsonDecode(rawData)[sequence.elementAt(0)][int.parse(sequence.elementAt(1))][sequence.elementAt(2)]; //This is weather condition
          else {
            String temperature = jsonDecode(rawData)[sequence.elementAt(0)][sequence.elementAt(1)].toString(); //This is temperature
            temperature = temperature.substring(0,2);
            if(temperature.contains('.'))
              temperature = temperature.substring(0,1);
            weatherDataMap[key] = temperature;
          }
        }
    }
    notifyListeners();
  }

  bool cityExists(String city){
    for(Map weatherData in _weatherDataMaps){
      if(weatherData['city'] == city){
        return true;
      }
    }
    return false;
  }

  Map cityWeather(String city){
    for(Map weatherData in _weatherDataMaps){
      if(weatherData['city'] == city){
        return weatherData;
      }
    }
    return null;
  }

  get weatherDataMaps{
    return _weatherDataMaps;
  }

  get cityWidget{
    return _cityWidgets;
  }
}