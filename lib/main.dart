import 'package:flutter/material.dart';
import 'package:learner/Interface/CitiesScreen.dart';
import 'package:learner/Interface/LoadingScreen.dart';
import 'package:learner/logic/Data.dart';
import 'package:provider/provider.dart';
main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
          home: LoadingScreen()
      ),
    );
  }
}