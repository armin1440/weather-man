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

  @override
  void initState() {
    super.initState();
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

              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Consumer<Data>(
                    builder: (context, data, child){
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: Provider.of<Data>(context).weatherScreenWidgetNumbers(widget.city),
                            itemBuilder: (context, index) => Provider.of<Data>(context).weatherScreenWidgets(widget.city)[index],
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
                      onPressed: () => Provider.of<Data>(context).updateWeather(widget.city),
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
}
