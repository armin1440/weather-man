import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/DataManager.dart';
import 'package:provider/provider.dart';
import 'TransparentWhiteBox.dart';
import 'package:learner/logic/Konstants.dart';

class WeatherScreen extends StatefulWidget {
  final String city;
  WeatherScreen(this.city);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<Widget> weatherScreenWidgets = [];
  String image = '';

  @override
  void initState() {
    super.initState();
    image = Provider.of<DataManager>(context, listen: false).getWeatherScreenPicture(widget.city);
    weatherScreenWidgets = [
      Consumer<DataManager>(
        builder: (context, data,child){
          return Text(
            "${Provider.of<DataManager>(context, listen: false).getWeatherInfo(widget.city,'weather description')}",
            style: informationTextStyle,
          );
        }
      ),
      SizedBox(height: 20,),
      Consumer<DataManager>(
        builder: (context, data, child){
          return  Text(
            "${Provider.of<DataManager>(context, listen: false).getWeatherInfo(widget.city,'temperature')} \u2103",
            style: informationTextStyle,
          );
        },
      ),
    ];
    initOption("humidity");
    initOption("feels_like");
    initOption("pressure");
    initOption("wind speed");
    Provider.of<DataManager>(context, listen: false).updateWeather(widget.city);
  }

  void initOption(String option){
    if ( Provider.of<DataManager>(context, listen: false).isOptionSelected(option) )
      addOption(option);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$image'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                TransparentWhiteBox(
                  child: Center(
                    child: Text("${widget.city}",
                      style: cityTitleWeatherScreenTextStyle,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Expanded(
                  child: TransparentWhiteBox(
                    child: Consumer<DataManager>(
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
                Center(
                  child: TransparentWhiteBox(
                    child: GestureDetector(
                      child: Text("update", style: informationTextStyle),
                      onTap: () => Provider.of<DataManager>(context, listen: false).updateWeather(widget.city),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addOption(String option){
    Map optionToUnit = { 'humidity': '%', 'wind speed': 'km/h', 'feels_like': '\u2103', 'pressure': 'hPa'};
    if( Provider.of<DataManager>(context, listen: false).getOptions[option] == true) {
      weatherScreenWidgets.add(SizedBox(height: 20,));
      weatherScreenWidgets.add(
        Consumer<DataManager>(
          builder: (context, data, child) {
            return Text(
              "${option.replaceAll("_", " ")} : ${Provider.of<DataManager>(context, listen: false)
                  .getWeatherInfo(widget.city,option)} ${optionToUnit[option]}",
              style: informationTextStyle,
            );
          },
        ),
      );
    }
    // print("addOption in weatherScreen called with option $option");
  }

}
