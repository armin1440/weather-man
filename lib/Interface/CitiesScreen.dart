import 'package:flutter/material.dart';
import 'package:learner/logic/Weather.dart';
import 'ColorfulBox.dart';

class CitiesScreen extends StatefulWidget{

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen>{
  List<Weather> weatherData = List<Weather>();
  String cityName;
  List<Widget> cities = List<Widget>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]) ),
              child: ColorfulBox(Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ListTile(
                  title: TextField(onChanged: (value){
                    cityName = value;
                  },
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                  trailing: FlatButton(
                    child: Icon(Icons.add, size: 30, color: Colors.white,),
                    onPressed: (){
                      setState(() {
                        addCity(cityName);
                        print(cities.length);
                      });
                    },
                  ),
                ),
              ),
              )
            ),
            SizedBox(height: 30,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: cities,
              ),
            )
          ],
        ),
      ),
    );
  }

  void addCity(String city){
    weatherData.add(Weather(city: city));
    Container toBeAddedCity = Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child:  Text(city, style: TextStyle(fontSize: 22, color: Colors.white),),
    );
    cities.add(ColorfulBox(toBeAddedCity));
  }

}