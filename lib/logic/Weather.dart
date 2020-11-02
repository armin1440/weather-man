import 'dart:convert';
import 'dart:io';

import 'HttpRequestManager.dart';

//This class has information about weather forecast of a certain city
class Weather{
  var _weatherForecast;
  String _city;
  HttpRequestManager _requestManager;

  Weather(String city){
    this._city = city;
    _requestManager = HttpRequestManager(city: city);
  }

  Future<String> getCurrentWeather() async{
    String weatherData = await _requestManager.sendRequest();
    print(weatherData);
    // if(weatherData != null)
    //   String tempFeelsLike = jsonDecode(weatherData)['main']['feels_like'];
    // print(tempFeelsLike);
    return weatherData;
  }
}