import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learner/Interface/CityTile.dart';
import 'package:learner/logic/Weather.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';

class Data extends ChangeNotifier{
  File _cityNamesFile;
  String _filePath;
  Position _location;
  List<CityTile> _cityWidgets =[];
  List<Weather> _weatherDatas =[];

  Data(){
    try {
      _getAccessToStoragePermission();
      _createFile();
    }
    catch (e){
      print(e);
    }
  }

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

  void addCity({@required Weather cityWeather}) async{
    bool isReady = await cityWeather.updateWeather();
    String cityName = cityWeather.getCity;
    if(!cityExists(cityName: cityName) && isReady) {
      _weatherDatas.add(cityWeather);
      _cityWidgets.add(CityTile(cityName));
      _saveToFile(cityName: cityName);
    }
    notifyListeners();
  }

  void _getAccessToStoragePermission() async{
    if (!await Permission.storage.isGranted)
      await Permission.storage.request();
  }

  void _createFile() async{
    final directory = await getApplicationDocumentsDirectory();
    _filePath = directory.path + "/cities.text";
    _cityNamesFile = File(_filePath);
    _cityNamesFile.createSync(recursive: true);
  }

  void _saveToFile({@required String cityName}) async{
    if (! await _cityNameExistInFile(cityName: cityName)) {
      var ioSink = _cityNamesFile.openWrite(mode: FileMode.append);
      ioSink.write("$cityName\n");
      ioSink.close();
    }
  }

  Future<bool> _cityNameExistInFile({@required String cityName}) async{
    Stream<String> lines = _cityNamesFile.openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());
    try {
      await for (var line in lines) {
        if(line == cityName)
          return true;
      }
    } catch (e) {
      print('Error: $e');
    }

    return false;
  }

  void removeCity({@required String cityName}) {
    if (cityExists(cityName: cityName)) {
      _removeCityWidget(cityName: cityName);
      _removeCityWeather(cityName: cityName);
      _updateCityNameFile();
    }
    notifyListeners();
  }

  void _updateCityNameFile(){
    _clearFile();
    _addCitiesFromWeatherDatas();
  }

  void _clearFile() async{
    var ioSink = _cityNamesFile.openWrite(mode: FileMode.write);
    int fileLength=1;
    while(fileLength!=0){
      ioSink.write("");
      fileLength = await _cityNamesFile.length();
    }
    ioSink.close();
  }
  
  void _addCitiesFromWeatherDatas() async{
    var ioSink = _cityNamesFile.openWrite(mode: FileMode.write);
    for(Weather weather in _weatherDatas){
      ioSink.write(weather.getCity+"\n");
    }
    ioSink.close();
  }

  Weather searchWeather({@required String cityName}){
    for(Weather weather in _weatherDatas){
      if(weather.getCity == cityName){
        return weather;
      }
    }
    return null;
  }

  bool cityExists({@required String cityName}){
    if(searchWeather(cityName: cityName) == null)
      return false;
    else
      return true;
  }

  void _removeCityWidget({@required String cityName}){
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