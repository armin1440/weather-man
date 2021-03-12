import 'package:flutter/material.dart';

class TransparentWhiteBox extends StatelessWidget {
  const TransparentWhiteBox({
    this.child,
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
