import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ColorfulBox.dart';
import 'CityTile.dart';

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<CityTile> cityWidgets = List<CityTile>();
  List<String> cityNames = List<String>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  itemCount: cityWidgets.length,
                  itemBuilder: (context, index) => cityWidgets[index],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void removeCity(String city){
    cityNames.remove(city);
    for(CityTile cityTile in cityWidgets){
      if(cityTile.city == city){
        cityWidgets.remove(cityTile);
      }
    }
  }

  void addCity(String city) {
    Function delete = (String sth) {
      setState(() {
        removeCity(sth);
      });
    };
    CityTile cityTile = CityTile(city, delete);
    cityWidgets.add(cityTile);
  }
}

