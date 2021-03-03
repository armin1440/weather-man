import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';
import 'Konstants.dart';
import 'Data.dart';

class DataManager extends ChangeNotifier{
  Data data;

  void update(Data data){
    // this.data = data;
    notifyListeners();
  }

  DataManager(this.data);

  Future<bool> findWeatherByLocation() async{
    Position location = await data.getLocation();
    // print("long : ${location.longitude} and lat : ${location.latitude}");
    Weather weatherOfHere = Weather(city: null);
    String weatherCast = "";

    if(location == null){
      // print("location is null");
      return false;
    }

    for(int i=0; i<5; i++){
      weatherCast = await weatherOfHere.getCurrentWeather(location: location);
      if(weatherCast.isNotEmpty)
        break;
    }
    if( weatherCast.isEmpty || jsonDecode(weatherCast)['cod'] == '404') {
      // print("city not found");
      return false;
    }
    // print("weathercast : $weatherCast");

    addCityByWeather(weatherOfHere);
    return true;
  }

  void addCityByWeather(Weather cityWeather){
    data.addCity(cityWeather: cityWeather);
    notifyListeners();
  }

  void addCityByName(String city) async{
    if(!data.cityExists(city) && city.isNotEmpty){
      Weather cityWeather = Weather(city: city);
      bool isRealCity = await cityWeather.updateWeather();
      if(isRealCity) {
        data.addCity(cityWeather: cityWeather);
      }
    }
    notifyListeners();
  }

  void removeCity(String city){
    data.removeCity(cityName: city);
    notifyListeners();
  }

  int cityNumbers(){
    return data.widgetNumbers();
  }

  Future<bool> updateWeather(String city) async{
    Weather weatherToUpdate = data.searchWeather(cityName: city);
    bool isUpdated = false;
    if(weatherToUpdate == null){
      return false;
    }
    else{
      isUpdated = await weatherToUpdate.updateWeather();
      notifyListeners();
    }
    return isUpdated;
  }

  get weatherDatas{
    return data.weatherDatas;
  }

  get cityWidgets{
    return data.cityWidgets;
  }

  void addOption(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    options[option.toLowerCase()] = true;
    //updateAll();
    notifyListeners();
  }

  void removeOption(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    options[option.toLowerCase()] = false;
    // updateAll();
    notifyListeners();
  }

  void updateAll(){
    for(Weather weather in data.weatherDatas)
      weather.updateWeather();
    notifyListeners();
  }

  bool isOptionSelected(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    // print("in isOptionSelected: ${options[option.toLowerCase()]}");
    return options[option.toLowerCase()];
  }

  Color getOptionButtonColor(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    return isOptionSelected(option) ? Colors.indigo : Colors.black38;
  }

  get getOptions{
    return options;
  }

  String getWeatherScreenPicture(String city){
    Weather weatherData = data.searchWeather(cityName: city);
    int id = weatherData.id;

    if(id == 800){
      var now = new DateTime.now();
      List clearSky = codeToPicture[800];
      if( now.hour> 18 ) {
        return clearSky[1];
      }else
        return clearSky[0];
    }
    return codeToPicture[id];
  }

  String getWeatherInfo(String city, String field){
    Weather weather = data.searchWeather(cityName: city);
    if(weather != null){
      switch(field){
        case 'temperature':
          return weather.temperature;
        case 'pressure':
          return weather.pressure;
        case 'humidity':
          return weather.humidity;
        case 'weather description':
          return weather.weatherDescription;
        case 'wind speed':
          return weather.windSpeed;
        case 'feels_like':
          return weather.feelsLike;
      }
    }
    return "null";
  }

  IconData getWeatherIcon(String city){
    Weather weather = data.searchWeather(cityName: city);
    if(weather != null)
      return weather.icon;
    else
      return WeatherIcons.refresh;
  }
}