import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

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
const Map codeToPicture = {
  800: ['sunny.jpg', 'night.jpg'] ,
  801: 'cloud.jpg', 802: 'cloud.jpg',
  803: 'cloud.jpg', 804: 'cloud.jpg',
  701: 'fog.jpg', 711: 'smoke.png',
  721: 'fog.jpg', 731: 'dust.jpg',
  741: 'fog.jpg', 751: 'sandStorm.jpg',
  761: 'dust.jpg', 762: 'volcano.jpg',
  771: 'rain.jpf', 781: 'tornado.png',
  600: 'snow.jpg',
  601: 'snow.jpg', 602: 'snow.jpg',
  611: 'snow.jpg', 612: 'snow.jpg',
  613: 'snow.jpg', 615: 'snow.jpg',
  616: 'snow.jpg', 620: 'snow.jpg',
  621: 'snow.jpg', 622: 'snow.jpg',
  500: 'rain.jpg', 501: 'rain.jpg',
  502: 'shower.jpg', 503: 'shower.jpg',
  504: 'shower.jpg', 511: 'rain.jpg',
  520: 'rain.jpg', 521: 'shower.jpg',
  522: 'shower.jpg', 531: 'shower.jpg',
  300: 'drizzle.jpg', 301: 'drizzle.jpg',
  302: 'drizzle.jpg', 310: 'rain.jpg',
  311: 'rain.jpg', 312: 'rain.jpg',
  313: 'shower.jpg', 314: 'shower.jpg',
  321: 'shower.jpg',
  200: 'thunderstorm.jpg', 201: 'thunderstorm.jpg',
  202: 'thunderstorm.jpg', 210: 'thunderstorm.jpg',
  211: 'thunderstorm.jpg', 212: 'thunderstorm.jpg',
  221: 'thunderstorm.jpg', 230: 'thunderstorm.jpg',
  231: 'thunderstorm.jpg', 232: 'thunderstorm.jpg',
};
final Map options = { 'humidity' : false, 'pressure': false, 'feels_like': false, 'wind speed': false};
final TextStyle informationTextStyle = GoogleFonts.oxygen(fontSize: 24, color: Colors.black);
final TextStyle optionTextStyle = GoogleFonts.oxygen(fontSize: 20, color: Colors.black);
final TextStyle bigOptionTextStyle = GoogleFonts.oxygen(fontSize: 40, color: Colors.black54);
final TextStyle cityTitleWeatherScreenTextStyle = GoogleFonts.oxygen(fontSize: 40, color: Colors.black);