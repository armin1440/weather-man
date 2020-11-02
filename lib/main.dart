import 'package:flutter/material.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final Tester tester = Tester();

  @override
  Widget build(BuildContext context) {
    tester.output();
    return(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 10),
              child: Column(children: <Widget>[
                Text(tester.output()),
              ],),
            ),
          ),
        ),
      )
    );
  }
}

class Tester{

  String output() {
    var listOfInts = [1, 2, 3, 4, 5, 6, 7];
    var listOfStrings = [
      '#0',
      for (var i in listOfInts) '#$i'
    ];
    for (String num in listOfStrings){
      print(num+ '\u{1f606}');
    }
    return "Done";
  }
}



