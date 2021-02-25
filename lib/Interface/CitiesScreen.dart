import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/DataManager.dart';
import 'ColorfulBox.dart';
import 'package:provider/provider.dart';
import 'NavigationBar.dart';

class CitiesScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(),
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
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
                        child: FlatButton(
                          child: Icon(Icons.add, size: 30, color: Colors.white,),
                          onPressed: () {
                              Provider.of<DataManager>(context, listen: false).addCityByName(_textEditingController.text);
                              _textEditingController.clear();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: FlatButton(
                            onPressed: () => Provider.of<DataManager>(context, listen: false).findWeatherByLocation(),
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
      ),
    );
  }

}

