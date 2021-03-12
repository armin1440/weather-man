import 'package:flutter/material.dart';

class SearchBarButton extends StatefulWidget {
  final Function onTapCallback;
  final IconData icon;
  SearchBarButton(this.onTapCallback, this.icon);
  @override
  _SearchBarButtonState createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton> {
  Color buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          buttonColor = Colors.orange;
        });
      },
      onTapUp: (details){
        setState(() {
          buttonColor = Colors.white;
        });
    },
    child: Icon(widget.icon, size: 30, color: buttonColor,),
      onTap: () {
      widget.onTapCallback();
      },
    );
  }
}
