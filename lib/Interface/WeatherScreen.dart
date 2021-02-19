import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Data.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';


const TextStyle informationTextStyle = TextStyle(color: Colors.black, fontSize: 25, decorationColor: Colors.lightBlueAccent);

class WeatherScreen extends StatefulWidget {
  final String city;
  WeatherScreen(this.city);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<Widget> weatherScreenWidgets = List();
  String image = '';

  @override
  void initState() {
    super.initState();
    image = Provider.of<Data>(context, listen: false).getWeatherScreenPicture(widget.city);
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
      Consumer<Data>(
        builder: (context, data, child){
          return  Text(
            "${Provider.of<Data>(context, listen: false).cityWeather(widget.city)['temperature']} \u2103",
            style: informationTextStyle,
          );
        },
      ),
    ];
    initOption("humidity");
    initOption("feels_like");
    initOption("pressure");
    initOption("wind speed");
    Provider.of<Data>(context, listen: false).updateWeather(widget.city);
  }

  void initOption(String option){
    if ( Provider.of<Data>(context, listen: false).isOptionSelected(option) )
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                TransparentWhiteBox(
                  child: Center(
                    child: Text("${widget.city}",
                      style: informationTextStyle.copyWith(fontSize: 33),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Expanded(
                  child: TransparentWhiteBox(
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
                Center(
                  child: TransparentWhiteBox(
                    child: FlatButton(
                      child: Text("update", style: informationTextStyle),
                      onPressed: () => Provider.of<Data>(context, listen: false).updateWeather(widget.city),
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
    if( Provider.of<Data>(context, listen: false).getOptions[option] == true) {
      weatherScreenWidgets.add(SizedBox(height: 20,));
      weatherScreenWidgets.add(
        Consumer<Data>(
          builder: (context, data, child) {
            return Text(
              "${option.replaceAll("_", " ")} : ${Provider.of<Data>(context, listen: false)
                  .cityWeather(widget.city)[option]} ${optionToUnit[option]}",
              style: informationTextStyle,
            );
          },
        ),
      );
    }
    // print("addOption in weatherScreen called with option $option");
  }

}

class TransparentWhiteBox extends StatelessWidget {
  const TransparentWhiteBox({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0x4CDDDDDD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      )
    );
  }
}
