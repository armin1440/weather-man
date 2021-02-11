import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learner/logic/Data.dart';
import 'ColorfulBox.dart';
import 'package:provider/provider.dart';
import 'OptionsScreen.dart';

class CitiesScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FlatButton(
        color: Colors.green,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OptionsScreen() )),
      ),
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: <Widget>[
              ColorfulBox(ListTile(
                title: TextField(
                  controller: _textEditingController,
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                trailing: FlatButton(
                  child: Icon(Icons.add, size: 30, color: Colors.white,),
                  onPressed: () {
                      Provider.of<Data>(context, listen: false).addCity(_textEditingController.text);
                      _textEditingController.clear();
                  },
                ),
              ),
                  ),
              SizedBox(height: 30,),
              Expanded(
                child: Consumer<Data>(
                  builder: (context, data, child){
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: Provider.of<Data>(context).cityNumbers(),
                      itemBuilder: (context, index) => Provider.of<Data>(context).cityWidget[index],
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

