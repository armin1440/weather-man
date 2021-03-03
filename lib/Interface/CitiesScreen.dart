import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/DataManager.dart';
import 'ColorfulBox.dart';
import 'package:provider/provider.dart';
import 'Option.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  int pageIndex = 0;
  Widget cities ;
  Widget options ;
  Widget pageContent;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    if(cities == null)
      cities = SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: <Widget>[
            ColorfulBox(
              ListTile(
                title: TextField(
                  controller: _textEditingController,
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: GestureDetector(
                          child: Icon(Icons.add, size: 30, color: Colors.white,),
                          onTap: () {
                            Provider.of<DataManager>(context, listen: false).addCityByName(_textEditingController.text);
                            _textEditingController.clear();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: GestureDetector(
                          onTap: () => Provider.of<DataManager>(context, listen: false).findWeatherByLocation(),
                          child: Icon(Icons.location_on_outlined, size: 30, color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: Consumer<DataManager>(
                builder: (context, data, child){
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: Provider.of<DataManager>(context).cityNumbers(),
                    itemBuilder: (context, index) => Provider.of<DataManager>(context).cityWidgets[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
    if(options == null)
      options = SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Text("Options", style: TextStyle(fontSize: 33),)),
              SizedBox(height: 10,),
              Option("Humidity"),
              Option("Wind speed"),
              Option("Pressure"),
              Option("Feels like"),
            ],
          ),
        ),
      ),
    );
    pages = [cities, options];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          elevation: 16,
          backgroundColor: Colors.blue.shade300,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.location_city), label: "Cities"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Options"),
          ],
          unselectedItemColor: Colors.indigo.shade300,
          selectedItemColor: Colors.indigo.shade900,
          currentIndex: pageIndex,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          }
      ),
      backgroundColor: Colors.lightBlue,
      body: pages[pageIndex],
    );
  }
}