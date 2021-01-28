import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/Interface/WeatherScreen.dart';
import 'package:learner/logic/Weather.dart';
import 'ColorfulBox.dart';
import 'CityTile.dart';

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Weather> weatherData = List<Weather>();
  String cityName;
  List<Widget> cities = List<Widget>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onDoubleTap:  (){ Navigator.pushNamed(context, WeatherScreen.id); } ,
      child: Scaffold(
        backgroundColor: Colors.cyan,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: <Widget>[
                ColorfulBox(ListTile(
                  title: TextField(
                    controller: _textEditingController,
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                  trailing: FlatButton(
                    child: Icon(Icons.add, size: 30, color: Colors.white,),
                    onPressed: () {
                      setState(() {
                        addCity(_textEditingController.text);
                        _textEditingController.clear();
                        print(cities.length);
                      });
                    },
                  ),
                ),
                    ),
                SizedBox(height: 30,),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cities.length,
                    itemBuilder: (context, index) => cities[index],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCity(String city) {
    weatherData.add(Weather(city: city));
    cities.add(Padding(
        child: CityTile(city),
        padding: EdgeInsets.only(bottom: 10.0)
    )
    );
  }
}

// onTap: Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CitiesScreen() ) ),