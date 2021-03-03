import 'package:flutter/material.dart';
import 'package:learner/Interface/LoadingScreen.dart';
import 'package:learner/logic/DataManager.dart';
import 'package:provider/provider.dart';
import 'package:learner/logic/Data.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(create: (_) => Data()),
        ChangeNotifierProxyProvider<Data, DataManager>(
          create: (BuildContext context) => DataManager(Provider.of<Data>(context, listen: false)),
          update: (BuildContext context, Data data, DataManager dataManager) => dataManager..update(data),
        ),
      ],
      child: MaterialApp(
          home: LoadingScreen()
      ),
    );
  }
}
