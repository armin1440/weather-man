import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

const String website = "https://api.openweathermap.org/data/2.5/weather?";
const String appId = "83289b6399002df3cd5f3ff9263e52f2";
const String units = "metric";

//This class sends a request to OpenWeatherMap.org and returns its response
class HttpRequestManager{
  HttpClient _client;
  String _city;
  HttpClientResponse _response;
  String responseBody;

  HttpRequestManager({String city}){
    _client = HttpClient();
    _city = city;
    responseBody = "";
  }

  Future<String> sendRequest({Position location}) async{
    String url;
    if (_city != null || location == null)
      url = website + "q=$_city&units=$units&appid=$appId";
    else
      url = website + 'lat=${location.latitude}&lon=${location.longitude}&appid=$appId&units=$units';

    await _client.getUrl(Uri.parse(url))
        .then((HttpClientRequest request) {
          return request.close();
        })
        .then((HttpClientResponse response) {
          _response = response;
        });
    _response.transform(utf8.decoder).listen((contents) {
      responseBody += contents;
    });
    // print("response : $responseBody");
    return responseBody;
  }

  void clearResponseBody(){
    responseBody = '';
  }

  void setCity(String cityName){
    if(_city == null || _city.isEmpty){
      _city = cityName;
    }
  }

}