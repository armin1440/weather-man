import 'package:flutter/material.dart';
import 'package:learner/logic/Konstants.dart';
import 'package:provider/provider.dart';
import 'package:learner/logic/DataManager.dart';

class Option extends StatelessWidget{
  final String title;
  Option(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0x9cDDDDDD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Text(title, style: optionTextStyle),
          trailing: Consumer<DataManager>(
            builder: (context, data, child){
              return GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Provider.of<DataManager>(context, listen: false).getOptionButtonColor(title),
                  ),
                ), // Only to prevent warning
                onTap: () {
                  if ( !Provider.of<DataManager>(context, listen: false).isOptionSelected(title) )
                    Provider.of<DataManager>(context, listen: false).addOption(title);
                  else
                    Provider.of<DataManager>(context, listen: false).removeOption(title);
                },
              );
            },
          ),
        ),
      ),
    );
  }

}