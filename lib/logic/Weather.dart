import 'HttpRequestManager.dart';

//This class contains information about weather forecast of a certain city.
class Weather{

  String _city;
  HttpRequestManager _requestManager;

  Weather({String city}){
    this._city = city;
    _requestManager = HttpRequestManager(city: city);
  }

  Future<String> getCurrentWeather() async{
    _requestManager.clearResponseBody();
    String weatherData = await _requestManager.sendRequest();
    print(weatherData.trim());
    return weatherData;
  }

  String get getCity{
    return _city;
  }
}