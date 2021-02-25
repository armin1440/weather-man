import 'dart:convert';
import 'Konstants.dart';
import 'HttpRequestManager.dart';
import 'package:geolocator/geolocator.dart';

//This class contains information about weather forecast of a certain city.
class Weather{

  String _name; //city name
  String _temperature;
  String _weatherDescription;
  int _id;
  String _humidity;
  String _pressure;
  String _windSpeed;
  String _feelsLike;
  HttpRequestManager _requestManager;
  var _icon;

  Weather({String city}){
    this._name = city;
    _requestManager = HttpRequestManager(city: city);
    // updateWeather();
  }

  Future<String> getCurrentWeather({Position location}) async{
    _requestManager.clearResponseBody();
    String weatherData;
    if(location == null) {
      _requestManager.setCity(_name);
      weatherData = await _requestManager.sendRequest();
    }
    else
      weatherData = await _requestManager.sendRequest(location: location);
    // print(weatherData.trim());
    return weatherData;
  }

  Future<bool> updateWeather() async{
    // Map weatherDataMap;
    // weatherDataMap = cityWeather(city);
    // Weather cityWeatherData = Weather(city: city);
    String rawData = '';

    for(int i=0; i<5 ;i++){
      rawData = await getCurrentWeather();
      if(rawData.isNotEmpty)
        break;
    }
    if(rawData.isEmpty){
      print('rawData is empty');
      return false;
    }
    if( rawData.isNotEmpty && rawData.contains("\"cod\":\"404\"") ){
      // print("error 404");
      return false;
    }
    if (rawData.isNotEmpty) {
      var response = jsonDecode(rawData);
      _name = response['name'];
      _weatherDescription = response['weather'][0]['description'];
      String temp = response['main']['temp'].toString();
      _temperature = adjustTemperature(temp);
      String feelLike = response['main']['feels_like'].toString();
      _feelsLike = adjustTemperature(feelLike);
      _humidity = response['main']['humidity'].toString();
      _id = response['weather'][0]['id'];
      _windSpeed = response['wind']['speed'].toString();
      _pressure = response['main']['pressure'].toString();
      setIcon();
      // print(this.toString());

      // for (String key in weatherDataMap.keys) {
      //   if(!jsonNotation.containsKey(key) )
      //     continue;
      //   String jsonSequence = jsonNotation[key];
      //   List<String> sequence = jsonSequence.split(" ");
      //   if(sequence.length == 3) {
      //     weatherDataMap[key] =
      //     jsonDecode(rawData)[sequence.elementAt(0)][int.parse(sequence.elementAt(1))][sequence.elementAt(2)]; //This is weather condition
      //     // print(weatherDataMap[key]);
      //   }else if(sequence.length == 2) {
      //     String temperature = jsonDecode(rawData)[sequence.elementAt(0)][sequence.elementAt(1)].toString(); //This is temperature
      //     if(temperature.length > 2)
      //       temperature = temperature.substring(0,2);
      //     if(temperature.contains('.'))
      //       temperature = temperature.substring(0,1);
      //     weatherDataMap[key] = temperature;
      //     // print(weatherDataMap[key]);
      //   }
      //   else{
      //     String name = jsonDecode(rawData)[sequence.elementAt(0)];
      //     weatherDataMap[key] = name;
      //   }
      // }

    }
    return true;
  }

  String adjustTemperature(String temp){
    String output = '';
    int index = temp.indexOf(".");
    if(index != -1){
      output = temp.substring(0,index);
    }
    else{
      if( temp.contains("-") ){
        if(temp.length >= 3)
          output = temp.substring(0,3);
        else
          output = temp.substring(0,2);
      }
      else{
        if(temp.length >= 2)
          output = temp.substring(0,2);
        else
          output = temp.substring(0,1);
      }
    }
    return output;
  }

  void setIcon(){
    if ( _id == 800 ){
      var now = new DateTime.now();
      List clearSky = weatherIdToIcon[800];
      if( now.hour> 18 ) {
        _icon = clearSky[1];
      }else
        _icon = clearSky[0];
    }
    else
      _icon = weatherIdToIcon[_id];
  }

  get getCity{
    return _name;
  }

  get id{
    return _id;
  }

  get temperature{
    return _temperature;
  }

  get pressure{
    return _pressure;
  }

  get feelsLike{
    return _feelsLike;
  }

  get humidity{
    return _humidity;
  }

  get windSpeed{
    return _windSpeed;
  }

  get weatherDescription{
    return _weatherDescription;
  }

  get icon{
    return _icon;
  }
}