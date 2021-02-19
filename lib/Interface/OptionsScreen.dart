import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Data.dart';
import 'package:provider/provider.dart';
import 'CitiesScreen.dart';

class OptionsScreen extends StatelessWidget {

  final Function changeColor = (Color color){
    if(color == Colors.black){
      color = Colors.blue;
    }
    else
      color = Colors.black;
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: NavigationBar(),
          backgroundColor: Colors.lightBlue,
          body: Padding(
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
        ),
    );
  }
}

class Option extends StatelessWidget{
  final String title;
  Option(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0x50DDDDDD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Text(title),
          trailing: Consumer<Data>(
            builder: (context, data, child){
              return FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                ),
                color: Provider.of<Data>(context, listen: false).getOptionButtonColor(title),
                onPressed: () {
                  if ( !Provider.of<Data>(context, listen: false).isOptionSelected(title) )
                    Provider.of<Data>(context, listen: false).addOption(title);
                  else
                    Provider.of<Data>(context, listen: false).removeOption(title);
                },
              );
            },
          ),
        ),
      ),
    );
  }

}