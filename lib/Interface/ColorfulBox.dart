import 'package:flutter/material.dart';

class ColorfulBox extends StatelessWidget {
  final Widget widget ;

  ColorfulBox(this.widget);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(colors: [Colors.blue, Colors.purple]) ),
      child: widget
    );
  }
}

