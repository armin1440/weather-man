import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Data.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

const TextStyle informationTextStyle = TextStyle(color: Colors.white, fontSize: 25, decorationColor: Colors.lightBlueAccent);

class WeatherScreen extends StatefulWidget {
  final String city;
  WeatherScreen(this.city);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<Widget> weatherScreenWidgets = List();

  @override
  void initState() {
    super.initState();
    weatherScreenWidgets = [
      Consumer<Data>(
        builder: (context, data,child){
          return Text(
            "${Provider.of<Data>(context, listen: false).cityWeather(widget.city)['weather']}",
            style: informationTextStyle,
          );
        }
      ),
      SizedBox(height: 20,),
      Row(
        children: [
          Consumer<Data>(
            builder: (context, data, child){
              return Text(
                "${Provider.of<Data>(context, listen: false).cityWeather(widget.city)['temperature']}",
                style: informationTextStyle,
              );
            },
          ),
          BoxedIcon(
            WeatherIcons.celsius,
            size: 33,
            color: Colors.white,
          ),
        ],
      ),
    ];
    if ( Provider.of<Data>(context, listen: false).isOptionSelected("humidity") )
      addOption("humidity");
    if ( Provider.of<Data>(context, listen: false).isOptionSelected("feels_like") )
      addOption("feels_like");
    if ( Provider.of<Data>(context, listen: false).isOptionSelected("pressure") )
      addOption("pressure");
    if ( Provider.of<Data>(context, listen: false).isOptionSelected("wind speed") )
      addOption("wind speed");
    Provider.of<Data>(context, listen: false).updateWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent, title: Text("Back"),),
        backgroundColor: Colors.lightBlueAccent,
        body: Container(
          color: Colors.lightBlueAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                    child: Consumer<Data>(
                        builder: (context, data, child){
                          return BoxedIcon(Provider.of<Data>(context).cityWeather(widget.city)['icon'], size: 180,);
                        },
                    ),
                  )
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Text("${widget.city}",
                    style: informationTextStyle.copyWith(fontSize: 33),
                  ),
              ),
              SizedBox(height: 30,),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Consumer<Data>(
                    builder: (context, data, child){
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: weatherScreenWidgets.length,
                            itemBuilder: (context, index) => weatherScreenWidgets[index],
                          );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.deepPurple ),
                    child: FlatButton(
                      child: Text("update", style: informationTextStyle),
                      onPressed: () => Provider.of<Data>(context, listen: false).updateWeather(widget.city),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  void addOption(String option){
    if( Provider.of<Data>(context, listen: false).getOptions[option] == true) {
      weatherScreenWidgets.add(SizedBox(height: 20,));
      weatherScreenWidgets.add(
        Consumer<Data>(
          builder: (context, data, child) {
            return Text(
              "$option : ${Provider.of<Data>(context, listen: false)
                  .cityWeather(widget.city)[option]}",
              style: informationTextStyle,
            );
          },
        ),
      );
    }
    print("addOption in weatherScreen called with option $option");
  }

}
