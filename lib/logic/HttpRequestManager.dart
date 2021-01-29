import 'dart:convert';
import 'dart:io';
const String website = "https://api.openweathermap.org";
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

  Future<String> sendRequest() async{
    String url = website + "/data/2.5/weather?q=$_city&units=$units&appid=$appId";
    // var httpRequest =
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
    return responseBody;
  }

  void clearResponseBody(){
    responseBody = '';
  }
}