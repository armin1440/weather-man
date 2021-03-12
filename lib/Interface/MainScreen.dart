import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/Interface/SearchBarButton.dart';
import 'package:learner/Interface/TransparentWhiteBox.dart';
import 'package:learner/logic/DataManager.dart';
import 'ColorfulBox.dart';
import 'package:provider/provider.dart';
import 'Option.dart';
import 'package:learner/logic/Konstants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  int pageIndex = 0;
  Widget citiesScreen;
  Widget optionsScreen;
  Color addButtonColor = Colors.white;
  Color locationButtonColor = Colors.white;
  Widget pageContent;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    if(citiesScreen == null)
      initCitiesScreen();
    if(optionsScreen == null)
      initOptionsScreen();

    pages = [citiesScreen, optionsScreen];
  }

  void initOptionsScreen(){
    optionsScreen = SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TransparentWhiteBox(child: Center(child: Text("Options", style: bigOptionTextStyle,))),
              SizedBox(height: 30,),
              Option("Humidity"),
              Option("Wind speed"),
              Option("Pressure"),
              Option("Feels like"),
            ],
          ),
        ),
      ),
    );
  }

  void initCitiesScreen(){
    citiesScreen = SafeArea(
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
                        child: SearchBarButton( (){
                          Provider.of<DataManager>(context, listen: false)
                              .addCityByName(_textEditingController.text);
                          _textEditingController.clear();
                        },
                          Icons.add,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: SearchBarButton(
                              (){
                            Provider.of<DataManager>(context, listen: false).findWeatherByLocation();
                          },
                          Icons.location_on_outlined,
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