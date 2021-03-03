import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learner/Interface/CityTile.dart';
import 'package:learner/logic/Weather.dart';

class Data extends ChangeNotifier{
  Position _location;
  List<CityTile> _cityWidgets =[];
  List<Weather> _weatherDatas =[];

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print( 'Location permissions are denied (actual value: $permission).');
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    _location = await Geolocator.getCurrentPosition();
    return _location;
  }

  void addCity({Weather cityWeather}) async{
    bool isReady = await cityWeather.updateWeather();
    String cityName = cityWeather.getCity;
    if(!cityExists(cityName) && isReady) {
      _weatherDatas.add(cityWeather);
      _cityWidgets.add(CityTile(cityName));
    }
    notifyListeners();
    // print("widgets:");
    // for(CityTile cityTile in _cityWidgets){
    //   print("${cityTile.city} widget exists");
    // }
    // print("weathers:");
    // for(Weather weather in _weatherDatas){
    //   print("${weather.getCity} weather exists");
    // }
  }


  void removeCity({String cityName}) {
    if (cityExists(cityName)) {
      _removeCityWidget(cityName: cityName);
      _removeCityWeather(cityName: cityName);
    }
    notifyListeners();
  }

  Weather searchWeather({String cityName}){
    for(Weather weather in _weatherDatas){
      if(weather.getCity == cityName){
        return weather;
      }
    }
    return null;
  }

  bool cityExists(String cityName){
    if(searchWeather(cityName: cityName) == null)
      return false;
    else
      return true;
  }

  void _removeCityWidget({String cityName}){
    CityTile cityTileToRemove;
    for(CityTile cityTile in _cityWidgets){
      if(cityTile.city == cityName){
        cityTileToRemove = cityTile;
      }
    }
    if(cityTileToRemove != null)
      _cityWidgets.remove(cityTileToRemove);
  }

  void _removeCityWeather({String cityName}){
    Weather weather = searchWeather(cityName: cityName);
    if(weather != null)
      _weatherDatas.remove(weather);
  }

  int widgetNumbers(){
    return _cityWidgets.length;
  }

  get weatherDatas{
    return List.unmodifiable(_weatherDatas);
  }

  get cityWidgets{
    return List.unmodifiable(_cityWidgets);
  }
}