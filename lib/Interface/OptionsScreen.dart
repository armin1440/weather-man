import 'package:flutter/material.dart';
import 'package:learner/logic/Data.dart';
import 'package:provider/provider.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Options", style: TextStyle(fontSize: 33),),
                SizedBox(height: 10,),
                Option("Humidity"),
                Option("Wind speed"),
                Option("Pressure"),
                Option("Feels_like"),
              ],
            ),
          ),
        ),
    );
  }
}

class Option extends StatefulWidget{
  final String title;
  Option(this.title);

  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(widget.title),
      trailing: RaisedButton(
        color: color,
        onPressed: () {
          setState(() {
            color = color == Colors.black ? Colors.blue : Colors.black;
            Provider.of<Data>(context, listen:false).addOption(widget.title);
          });
        },
      ),
    );
  }
}