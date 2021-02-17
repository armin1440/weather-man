import 'HttpRequestManager.dart';
import 'package:geolocator/geolocator.dart';

//This class contains information about weather forecast of a certain city.
class Weather{

  String _city;
  HttpRequestManager _requestManager;

  Weather({String city}){
    this._city = city;
    _requestManager = HttpRequestManager(city: city);
  }

  Future<String> getCurrentWeather({Position location}) async{
    _requestManager.clearResponseBody();
    String weatherData;
    if(location == null)
      weatherData = await _requestManager.sendRequest();
    else
      weatherData = await _requestManager.sendRequest(location: location);
    print(weatherData.trim());
    return weatherData;
  }

  String get getCity{
    return _city;
  }
}