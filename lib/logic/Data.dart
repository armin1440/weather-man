
import 'package:flutter/cupertino.dart';
import 'package:learner/Interface/CityTile.dart';

class Data extends ChangeNotifier{
  List<CityTile> _cityWidget = List<CityTile>();
  List<String> _cityNames = List<String>();

  void addCity(String city){
    _cityNames.add(city);
    _cityWidget.add(CityTile(city));
    notifyListeners();
  }

  void removeCity(String city){
    _cityNames.remove(city);
    for(CityTile cityTile in _cityWidget){
      if(cityTile.city == city) {
        _cityWidget.remove(cityTile);
        break;
      }
    }
    notifyListeners();
  }

  int widgetNumbers(){
    return _cityWidget.length;
  }

  get cityWidget{
    return _cityWidget;
  }
}