import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/Interface/CityTile.dart';
import 'package:learner/logic/Weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:geolocator/geolocator.dart';

const Map jsonNotation = {'name': 'name','temperature': 'main temp', 'weather' : 'weather 0 description', 'id' : 'weather 0 id',
  'humidity': 'main humidity', 'pressure': 'main pressure', 'wind speed': 'wind speed', "feels_like": 'main feels_like' };
const Map weatherIdToIcon = {
  0: WeatherIcons.cloud_refresh,
  800: [WeatherIcons.day_sunny, WeatherIcons.night_clear] ,
  801: WeatherIcons.cloudy, 802: WeatherIcons.cloudy,
  803: WeatherIcons.cloudy, 804: WeatherIcons.cloudy,
  701: WeatherIcons.fog, 711: WeatherIcons.smoke,
  721: WeatherIcons.fog, 731: WeatherIcons.dust,
  741: WeatherIcons.fog, 751: WeatherIcons.sandstorm,
  761: WeatherIcons.dust, 762: WeatherIcons.volcano,
  771: WeatherIcons.rain_wind, 781: WeatherIcons.tornado,
  600: WeatherIcons.snow,
  601: WeatherIcons.snow, 602: WeatherIcons.snow,
  611: WeatherIcons.snow, 612: WeatherIcons.snow,
  613: WeatherIcons.snow, 615: WeatherIcons.rain_mix,
  616: WeatherIcons.snow, 620: WeatherIcons.snow,
  621: WeatherIcons.snow, 622: WeatherIcons.snow,
  500: WeatherIcons.rain, 501: WeatherIcons.rain,
  502: WeatherIcons.showers, 503: WeatherIcons.showers,
  504: WeatherIcons.showers, 511: WeatherIcons.rain,
  520: WeatherIcons.rain, 521: WeatherIcons.showers,
  522: WeatherIcons.showers, 531: WeatherIcons.showers,
  300: WeatherIcons.raindrop, 301: WeatherIcons.raindrop,
  302: WeatherIcons.raindrops, 310: WeatherIcons.rain,
  311: WeatherIcons.rain, 312: WeatherIcons.rain,
  313: WeatherIcons.showers, 314: WeatherIcons.showers,
  321: WeatherIcons.showers,
  200: WeatherIcons.thunderstorm, 201: WeatherIcons.thunderstorm,
  202: WeatherIcons.thunderstorm, 210: WeatherIcons.thunderstorm,
  211: WeatherIcons.thunderstorm, 212: WeatherIcons.thunderstorm,
  221: WeatherIcons.thunderstorm, 230: WeatherIcons.thunderstorm,
  231: WeatherIcons.thunderstorm, 232: WeatherIcons.thunderstorm,
};
final Map options = { 'humidity' : false, 'pressure': false, 'feels_like': false, 'wind speed': false};
const TextStyle informationTextStyle = TextStyle(color: Colors.white, fontSize: 25, decorationColor: Colors.lightBlueAccent);

class Data extends ChangeNotifier{
  Position location;
  List<CityTile> _cityWidgets = List<CityTile>();
  List<Map> _weatherDataMaps = List<Map>();

  void getLocation() async{
    location = await _determinePosition();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void findWeatherByLocation() async{
    getLocation();
    // print("lat : ${location.latitude} and long: ${location.longitude}");
    Weather weather = Weather(city: null);
    String weatherCast = "";
    for(int i=0 ; i<5 ; i++){
      weatherCast = await weather.getCurrentWeather(location: location);
      if(weatherCast.isNotEmpty)
        break;
    }
    print("weather cast : $weatherCast");
    String cityName = jsonDecode(weatherCast)["name"];
    addCity(cityName);
  }

  void addCity(String city) async{
    if(!cityExists(city) && city.isNotEmpty){
      Map dataMap = {'name': city, 'temperature': '?', 'weather': '?', 'id': 0, 'icon': WeatherIcons.cloud_refresh,
      'humidity' : '?', 'pressure': '?', 'wind speed': '?', 'feels_like': '?'};
      _weatherDataMaps.add(dataMap);
      bool isRealCity = await updateWeather(city);
      if(isRealCity) {
        city = dataMap['name'];
        _cityWidgets.add(CityTile(city));
      }
      notifyListeners();
    }
  }

  void removeCity(String city){
    if(cityExists(city)) {
      print("here");
      for(Map weatherData in _weatherDataMaps){
        if(weatherData['city'] == city){
          _weatherDataMaps.remove(weatherData);
          // print("$city weather removed from maps");
          break;
        }
      }
      for (CityTile cityTile in _cityWidgets) {
        if (cityTile.city == city) {
          _cityWidgets.remove(cityTile);
          // print("$city weather removed from widgets");
          break;
        }
      }
      notifyListeners();
    }
  }

  int cityNumbers(){
    return _cityWidgets.length;
  }

  Map cityWeather(String city){
    for(Map weatherData in _weatherDataMaps){
      if(weatherData['name'] == city){
        return weatherData;
      }
    }
    return null;
  }

  Future<bool> updateWeather(String city) async{
    Map weatherDataMap;
    weatherDataMap = cityWeather(city);
    Weather cityWeatherData = Weather(city: city);
    String rawData = '';
    int i = 0;
    while(rawData.isEmpty && i < 5){
      rawData = await cityWeatherData.getCurrentWeather();
      i++;
    }
    if( rawData.isNotEmpty & rawData.contains("\"cod\":\"404\"") ){
      removeCity(city);
      return false;
    }
    else if (rawData.isNotEmpty) {
        for (String key in weatherDataMap.keys) {
          if(!jsonNotation.containsKey(key) || (options.containsKey(key) && options[key] == false))
            continue;
          String jsonSequence = jsonNotation[key];
          List<String> sequence = jsonSequence.split(" ");
          if(sequence.length == 3) {
            weatherDataMap[key] =
            jsonDecode(rawData)[sequence.elementAt(0)][int.parse(sequence.elementAt(1))][sequence.elementAt(2)]; //This is weather condition
            // print(weatherDataMap[key]);
          }else if(sequence.length == 2) {
            String temperature = jsonDecode(rawData)[sequence.elementAt(0)][sequence.elementAt(1)].toString(); //This is temperature
            if(temperature.length > 2)
              temperature = temperature.substring(0,2);
            if(temperature.contains('.'))
              temperature = temperature.substring(0,1);
            weatherDataMap[key] = temperature;
            // print(weatherDataMap[key]);
          }
          else{
            String name = jsonDecode(rawData)[sequence.elementAt(0)];
            weatherDataMap[key] = name;
          }
        }
        setIcon(weatherDataMap['name']);
        for(String key in weatherDataMap.keys){
          print("$key : $weatherDataMap[$key]");
          break;
        }
    }
    notifyListeners();
    return true;
  }

  bool cityExists(String city){
    for(Map weatherData in _weatherDataMaps){
      if(weatherData['name'] == city ){
        return true;
      }
    }
    return false;
  }

  get weatherDataMaps{
    return _weatherDataMaps;
  }

  get cityWidget{
    return _cityWidgets;
  }

  void setIcon(String city){
    Map weatherData = cityWeather(city);
    if ( weatherData['id'] == 800 ){
      var now = new DateTime.now();
      List clearSky = weatherIdToIcon[800];
      if( now.hour> 18 ) {
        weatherData['icon'] = clearSky[1];
      }else
        weatherData['icon']= clearSky[0];
    }
    else
      weatherData['icon']= weatherIdToIcon[weatherData['id']];
  }

  void addOption(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    options[option.toLowerCase()] = true;
    for(Map map in _weatherDataMaps){
      updateWeather(map['name']);
    }
    notifyListeners();
  }

  void removeOption(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    options[option.toLowerCase()] = false;
    for(Map map in _weatherDataMaps){
      updateWeather(map['name']);
    }
    notifyListeners();
  }

  bool isOptionSelected(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    // print("in isOptionSelected: ${options[option.toLowerCase()]}");
    return options[option.toLowerCase()];
  }

  Color getOptionButtonColor(String option){
    option = option.toLowerCase() == 'feels like' ? 'feels_like' : option;
    return isOptionSelected(option) ? Colors.blue : Colors.black;
  }

  get getOptions{
    return options;
  }
}